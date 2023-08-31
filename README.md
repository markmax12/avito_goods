#  Тестовое задание для стажёра iOS

## Детали решения
Решение находится в папке avito_goods. Для запуска откройте `avito_goods.xcodeproj`.
* Архитектура - MVVM + Coordinator 
* Используется UICollectionView + CompoitionalLayout
* Для кеширования используется сторонняя зависимость в виде Kingfisher
* Для работы с сетью - обертка над URLSession `Core/Network/NetworkManager.swift`
* Для реализации состоянии экранов используется связка ViewModel, ViewState + ViewController при помощи Combine, см. пример `Modules/MainPage/MainPageViewModel.swift` и `Modules/MainPage/MainPageViewController.swift`

# Скриншоты
<img width="359" alt="Screenshot 2023-08-31 at 23 37 58" src="https://github.com/markmax12/avito_goods/assets/83367510/c1d4f0de-e06d-41dc-8bf9-876042cdd558">
<img width="359" alt="Screenshot 2023-08-31 at 23 37 58" src="https://github.com/markmax12/avito_goods/assets/83367510/6f568c76-2f97-4261-b02d-1847386fbd23">
<img width="359" alt="Screenshot 2023-08-31 at 23 37 58" src="https://github.com/markmax12/avito_goods/assets/83367510/141cf406-a251-429c-b7e8-cd9a83132f76">
<img width="359" alt="Screenshot 2023-08-31 at 23 37 58" src="https://github.com/markmax12/avito_goods/assets/83367510/f31e6e39-1646-4128-a95a-4a55f3fb3ae0">
