MultiPult
=========

My site also is http://innenashev.narod.ru.
Download latest MultPult You can by link https://github.com/Nashev/MultiPult/raw/origin/bin/MultiPult.exe

Первоначальный проект выглядел так:
===================================

Программа "МультиПульт" Версия 1.0
----------------------------------

Текущая версия расположена по адресу: https://github.com/Nashev/MultiPult 
Там же расположен список предстоящих доработок и его обсуждение.

Программа предназначена для компьютерного монтажа мультфильмов в реальном времени на основе уже созданных (или загруженных в компьютер) изображений (элементарный VJ-ing с записью)

Позволяет:
* Просматривать фотографии вручную или автоматически (с заданной частотой кадров) (для этого сами фотографии должны быть достаточно компактными, чтобы переход от  одной к другой не занимал много времени)
* Записывать звук с микрофона и синхронно записывать последовательность просматриваемых кадров (именно последовательность, а не экраны!)
* Воспроизводить создаваемые записи ( фотографии в соответствии с временем и звуковой файл – всё вместе называется "фильм")
* Экспортировать фильмы в формат AVI

Просмотр, запись и воспроизведение - 3 режима, которые должны как-то ясно индицироваться, чтобы пользователь понимал, что сейчас происходит и что он может делать.

Основные функции версии 1.0
----------------------------------

* Выбор папки с фотографиями через стандартный интерфейс операционной системы (отображает первую (или указанную в папке) фотографию).
* Создание нового фильма. В выбранной (текущей) папке создаётся пара пустых файлов для записи в них будущего фильма:
* Звуковой файл (WAV) – .
* Файл данных (DAT) представляет собой имена картинок из текущей папки – и указания в какой момент от начала записи звука (в миллисекундах) конкретную картинку показывать, плюс дополнительный служебный тег, в котором в дальнейших версиях будет располагаться всяческая служебная информация
* Открывание уже существующего фильма для воспроизведения. После открывания на экране первый из кадров фильма
* Воспроизведение фильма. Звук и картинки воспроизводятся синхронно. Пробел останавливает и продолжает воспроизведение.
* Просмотр фотографий из папки с помощью клавиатуры (см. Горячие клавиши) 
* Запись фильма. Включается во время просмотра фотографий. При этом просмотр продолжается, и вместе с ним происходит синхронное дописывание в открытые файлы двух потоков данных:
* Запись ЗВУКА с микрофона (WAV)
* Запись ИМЁН ФАЙЛОВ (DAT) просматриваемых фотографий, и временнЫх привязок. 
* Экспорт фильма в формат AVI с частотой 25 кадров в секунду. (Технически проще всего создавать при этом в отдельной папке пакет картинок со всеми кадрами будущего фильма – по 25 кадров на каждую секунду, а потом собрать эти кадры в ролик, подкладывая к нему звуковую дорожку)


Горячие клавиши версии 1.0 (действуют в режиме просмотра кадров и записи фильма)

 → – следующая фотография

 ← – предыдущая фотография

 ↓ - запускает и останавливает проигрывание кадров ВПЕРЁД с заданной скоростью

 ↑ - запускает и останавливает проигрывание кадров НАЗАД с заданной скоростью

 Контрол  +  ↓  – последний кадр (автоматический показ прекращается)

 Контрол  +  ↑  – первый кадр (автоматический показ не прекращается, если он включён)

 Пробел  – запуск и останов записи – в уголке появляется/исчезает компактный значок записи

Перспективы дальнейшего развития системы
----------------------------------

* Возможность кроме картинок включать в просматриваемый пакет видеоролики. Видео-ролик при просмотре выглядит как просто картинка, а по нажатии пробела – запускается и останавливается его просмотр. В Фильме, соответственно ссылка на этот ролик сохраняется в файле данных – откуда и докуда крутить. При экспорте соответственно тоже берутся кадры этого ролика и вставляются в готовый фильм AV
* Возможность назначать метки и запускать просмотр с нужной метки
* Возможность при просмотре и при записисоздания зацикленных фрагментов
* Элементарное редактирование 
    * разделить на два фильма (по указателю)
    * выделить фрагмент фильма
    * урезать до выделенного
    * вставить другой фильм от указателя в разрыв
    * вставить другой фильм от указателя внахлёст (замена)

Дополнение:

Горячие клавиши версии 1.1 (действуют в режиме просмотра и записи)

 → – следующая фотография

 ← – предыдущая фотография

 ↓   запускает и останавливает проигрывание кадров вперёд с заданной скоростью

 ↑  запускает и останавливает проигрывание кадров назад с заданной скоростью

 Контрол  + → – следующая метка (автоматический показ не прекращается, если он включён)

 Контрол  + ← – предыдущая метка (автоматический показ не прекращается, если он включён)

 Контрол  +  ↓    – последний кадр (автоматический показ прекращается)

 Контрол  +  ↑   – первый кадр (автоматический показ не прекращается, если он включён)

 Пробел  – запуск и останов записи – в уголке появляется/исчезает компактный значок записи

 A – начало выделения

 S  – конец выделения 

 D – зацикливает просмотр в рамках выделения

 F  – отменяет зацикливание

 Энтер  – установить очередную метку (номер метки на секунду зажигается в верхнем левом углу)

 1   2   3   4   5   6   7   8   9   0  - Переход на соответствующую метку (номер метки на секунду зажигается в верхнем левом углу 0 – соответствует 10 метке)
Метка может быть также сочетанием двух клавиш - цифровой и любой другой (цифровой или буквенной)


 Контрол  +  “Клавиши метки”   - установка или снятие соответствующей метки в текущей позиции

Через альт или через шифт + “Клавиши метки” устанавливается “Окончание цикла метки” или выражаясь по Илюшиному “Телепорт на метку

Этот телепорт работает только если включён режим срабатывания возвратов (зацикливания) - впрочем, это ещё надо обсудить

Нужен режим полного экрана

Да! ещё: у клавиш перехода на один кадр вперёд и на один кадр назад должны быть дублёры - чтобы можно было колотить двумя руками двигая вперёд и назад. По идее это должны быть 4 клавиши в нижнм ряду. Примерно так:
z - вперёд
x - назад
c - назад
v - вперёд
Ну или как-то так