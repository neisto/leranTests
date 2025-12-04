*** Settings ***
Documentation    Набор тестов для проверки функциональности сайта Leran.
Resource    leran.resource
Test Setup    Precondition: Open Browser CHROME
Test Teardown    Poscondition: Close Browser


*** Variables ***
${PAYMENTS}    xpath=//span[contains(@class, 'basket-payments__tabs-el')
...    and not(contains(@class, 'basket-payments__tab-online_text-mobile'))]
${COUNT_PAYMENTS}    6
${BTN_PAYMENTS}    xpath=//a[contains(@class, 'basket-confirm__button')]


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
    Check Payments


*** Keywords ***
Check Payments
    [Documentation]    Прокручиваем к разделу платежей => Получаем все элементы платежей => Проходим по каждому элементу
    Scroll Element Into View    ${BTN_PAYMENTS}
    Sleep    1s
    @{PAY_LIST}=    Get WebElements    ${PAYMENTS}
    ${COUNT}=    Get Length    ${PAY_LIST}
    Log    Найдено платежных методов: ${COUNT}
    Should Be Equal As Numbers     ${COUNT}    ${COUNT_PAYMENTS}    msg="колчество способов оплаты не равно 6"
    FOR    ${PAY_ELEM}    IN    @{PAY_LIST}
        Click Element    ${PAY_ELEM}
        Sleep    2s
    END
