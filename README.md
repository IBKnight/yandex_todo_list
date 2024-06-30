# yandex_todo_list
### Не было, не было и вот опять!
# "Величайший туду лист" - задание с ШМР Яндекс трек Flutter

## Список фич на данный момент
- Мейн списочек задач на главном экране.
- В хедере указано количество выполненных задач, также с помощью "глазика" можно их скрыть или отобразить.
- Уникальность внешний вид у задач разного приоритета.
- Отображение даты дедлайна.
- 2 опции свайпа: вправо - отметить задачу как выполненную, влево - удалить задачу из списка.
- Можно зайти в создание/редактирование фичи, выбрать там дату дедлайна, приоритет и описать суть задачи.
- Все задачи хранятся на сервере
- Также при стягивании данных с сервера задачки сохраняются в локальную бдшку(Пока что кривенько, но дальше лучше)

## Примечение: приложение работает нормально только со светлой системной темой, пока не было задания на тему, я особо не заморачивался, но в будущих апдейтах, господа, всё будет! Приятного пользования)

Если хотите запустить в дебаге, то создаёте launch.json, в него вставляете этот код с подстановкой вашего токена и BASE_URL
```json
{
    "configurations": [
        {
            "name": "Flutter",
            "request": "launch",
            "type": "dart",
            "flutterMode": "debug",
            "toolArgs": [
                "--dart-define",
                "BASE_URL=<...>",
                "--dart-define",
                "APP_TOKEN=<...>",
            ]
        }
    ]
}
```

## Скриншотики

<div  style="display: flex; justify-content: center;">
    <img src="assets/screenshots/screenshot1.png" alt="Screenshot 1" style="width: 100px; margin-right: 10px;">
    <img src="assets/screenshots/screenshot2.png" alt="Screenshot 2" style="width: 100px; margin-right: 10px;">
    <img src="assets/screenshots/screenshot3.png" alt="Screenshot 3" style="width: 100px; margin-right: 10px;">
    <img src="assets/screenshots/screenshot4.png" alt="Screenshot 4" style="width: 100px; margin-right: 10px;">
</div>

## Ссылка на .APK
[Ссылочка на .apk](https://github.com/IBKnight/yandex_todo_list/releases/tag/v1.0.4)
