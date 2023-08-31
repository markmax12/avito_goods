#  Тестовое задание для стажёра iOS

## Детали решения
Решение находится в папке avito_goods. Для запуска откройте `avito_goods.xcodeproj`.
* Архитектура - MVVM + Coordinator 
* Используется UICollectionView + CompoitionalLayout
* Для кеширования используется сторонняя зависимость в виде Kingfisher
* Для работы с сетью - обертка над URLSession `Core/Network/NetworkManager.swift`
* Для реализации состоянии экранов используется связка ViewModel, ViewState + ViewController при помощи Combine, см. пример `Modules/MainPage/MainPageViewModel.swift` и `Modules/MainPage/MainPageViewController.swift`
