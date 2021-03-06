$(document).ready(function() {
    // original code from habr-article
    
    var dropZone = $('#dropZone'),
        maxFileSize = 100000000; // 100 мб (Also nginx limitations).
    
    // Проверка поддержки браузером
    if (typeof(window.FileReader) == 'undefined') {
        dropZone.text('Не поддерживается браузером!');
        dropZone.addClass('error');
    }
    
    // Добавляем класс hover при наведении
    dropZone[0].ondragover = function() {
        dropZone.addClass('hover');
        return false;
    };
    
    // Убираем класс hover
    dropZone[0].ondragleave = function() {
        dropZone.removeClass('hover');
        return false;
    };
    
    // Обрабатываем событие Drop
    dropZone[0].ondrop = function(event) {
        event.preventDefault();
        dropZone.removeClass('hover');
        dropZone.addClass('drop');
        
        var file = event.dataTransfer.files[0];
        
        // Проверяем размер файла
        if (file.size > maxFileSize) {
            dropZone.text('Файл слишком большой!');
            dropZone.addClass('error');
            return false;
        }
        
        // Создаем запрос
        var xhr = new XMLHttpRequest();
        xhr.upload.addEventListener('progress', uploadProgress, false);
        xhr.onreadystatechange = stateChange;
        xhr.open('POST', '/nodes/dnd');
	xhr.setRequestHeader("Content-Type", "application/octet-stream"); // One of hacks
        xhr.setRequestHeader('X-File-Name', file.name); 
        xhr.send(file);
    };
    
    // Показываем процент загрузки
    function uploadProgress(event) {
        var percent = parseInt(event.loaded / event.total * 100);
        dropZone.html('Загрузка<br/><div class="progress progress-striped active"><div class="bar" style="width:'+percent+'%;"></div></div>');
    }
    
    // Пост обрабочик
    function stateChange(event) {
        if (event.target.readyState == 4) {
            if (event.target.status == 200) {
                dropZone.html('<i class="icon-share"></i> Для загрузки, перетащите файл сюда.');
		$.get("/nodes/table",function(data){
			$('#main').html(data);
		});
            } else {
                dropZone.text('Произошла ошибка!');
                dropZone.addClass('error');
            }
        }
    }    
});

