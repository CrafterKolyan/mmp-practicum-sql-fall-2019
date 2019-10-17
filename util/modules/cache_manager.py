import os
import datetime
import json
import pytz


PROJECT_DIRECTORY = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
CACHE_DIRECTORY = os.path.join(PROJECT_DIRECTORY, "util/cached_queries")
os.makedirs(CACHE_DIRECTORY, mode=0o777, exist_ok=True)


def get_cached_query_file_path(file_path):
    file_path = os.path.basename(file_path)[:-4]
    full_path = os.path.join(CACHE_DIRECTORY, f"{file_path}.json")
    return full_path


def get_current_msk_time():
    msk_timezone = pytz.timezone('Europe/Moscow')
    return datetime.datetime.now(msk_timezone)


def get_cached_query(file_path, content):
    if not file_path.endswith(".sql"):
        return {}
    full_path = get_cached_query_file_path(file_path)
    if not os.path.isfile(full_path):
        return {}
    cached_query = json.load(open(full_path))
    valid_until = datetime.datetime.fromtimestamp(cached_query['valid_until'])
    if valid_until < get_current_msk_time() or cached_query['sql'] != content:
        os.remove(full_path)
        return {}
    cached_query['data'] = ((cached_query['data'],),)
    return cached_query


def set_cached_query(file_path, content, result, valid_for=None):
    if valid_for == 'day':
        valid_until = get_current_msk_time() + datetime.timedelta(days=1)
        valid_until = datetime.datetime.combine(valid_until.date(), datetime.time.min)
        valid_until += datetime.timedelta(minutes=5)
    else:
        valid_until = datetime.datetime.max
    cached_query = {
        'sql': content,
        'valid_until': valid_until.timestamp(),
        'rows': len(result),
        'hash': hash(result),
        'data': str(result[0]) if len(result) > 0 else ""
    }
    full_path = get_cached_query_file_path(file_path)
    json.dump(cached_query, open(full_path, 'w', encoding='utf-8'))