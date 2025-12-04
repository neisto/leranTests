*** Settings ***
Documentation    Набор тестов для проверки функциональности сайта Leran.
Resource    leran.resource
Test Setup    Precondition: Open Browser CHROME
Test Teardown    Poscondition: Close Browser


*** Test Cases ***
Open site and add goods
    [Documentation]    Открыть каталог => навестись на элемент "Кухонная техника" => открыть категорию "Холодильники" =>
    ...  добавить в корзину 1й товар в списке => подтвердить выбор нажатием кнопки "Оформить заказ" =>
    ...  открыть корзину и убедиться, что товар добавлен.

    Go To Catalog
    Hover Over Kitchen Appliances
    Go To Refrigerators
    Add First Product To Cart
    Confirm Order
    Go To Cart
    Check Cart Contains Product Image
