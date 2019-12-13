Для создания резервной копии слайдов использовался следующий Javascript код ([источник](https://medium.com/@ajaytvn/how-to-download-google-slide-presentations-published-to-the-web-3c1564bd92c1)):
```{javascript}
var atag = "punch-viewer-content",
    btag = "goog-flat-menu-button-caption",
    ctag = "aria-setsize",
    dtag = "aria-posinset",
    msvg = document.getElementsByTagName("svg"),
    node = document.getElementsByClassName(btag)[0],
    view = document.getElementsByClassName(atag)[0],
    size = node.getAttribute(ctag);
for(var i = 0, data = ""; i!=size; view.click())
   i = node.getAttribute(dtag), data += msvg[0].outerHTML;
document.write(data);
```

Инструкция по использованию в Chrome:
1. Открыть ссылку на показ презентации
2. Ctrl + Shift + I
3. Вставить код представленный выше
4. Сохранить страницу в формате `.html`