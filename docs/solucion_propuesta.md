### Pasos:

1.  Cuando el usuario ejecuta la función `ImageFinder.fetch/2` pasandole una lista de archivos y una carpeta destino, estos son pasados al `ImageFinder.Supervisor` que los redirige al `ImageFinder.FileParser.Supervisor` para su proceso.
2.  `FileParser.Supervisor` crea un `FileParser.Worker` por cada archivo.
3.  Usar `FileParser.Worker.extract` para obtener los enlaces de cada archivo.
4.  Enviar los enlaces a `FileParser.Supervisor`.
5.  Tomar los resultados (de la forma `[{domain, link}]`) y transformarlos a una lista `[{domain, [links]}]`.
6.  Enviar la lista al `ImageFinder.Supervisor`.
7.  `ImageFinder.Supervisor` debe enviar dicho lista con los enlaces por dominio a `Fetcher.Supervisor`.
8.  `Fetcher.Supervisor` crea un `Fetcher.Worker` por cada dominio en la lista (# de elementos).
9.  Cada `Fetcher.Worker` toma la lista de enlaces y descarga cada uno de forma secuencial (tener en cuenta el manejo de errores).
10. Luego de descargar los archivos, cada `Fetcher.Worker` envia al `Fetcher.Supervisor` la información de la descarga, por ejemplo si hubo algun error, su cantidad, etc.
11. `Fetcher.Supervisor` junta los resultados y los envia a `ImageFinder.Supervisor`.
12. `ImageFinder.Supervisor` muestra los resultados y (opcionalmente) los persiste (esta información puede ser usada para bloquear dominios).

### Plan de implementación:

1.  Implementar `ImageFinder.FileParser.Supervisor`. ** Hecho**
2.  Implementar `ImageFinder.FileParser.Worker`. ** Hecho **
3.  Implementar funciones para recibir datos en `ImageFinder.Supervisor`.
4.  Implementar `ImageFinder.Fetcher.Supervisor`.
5.  Implementar `ImageFinder.Fetcher.Worker`.
6.  Implementar las funciones para recibir los datos en `ImageFinder.Supervisor`.
7.  Implementar la logica para guardar en una `:dets`.

### Anexo:

1.  Ver de usar Task.Supervisor en vez de genserver.
