*** Settings ***
Documentation    Набор тестов для проверки функциональности сайта Leran.
Library    SeleniumLibrary


*** Variables ***
${BROWSER}    chrome
${SITE}    https://www.leran.pro

${CATALOG_LINK}                     xpath=//a[@data-ajax-url="/catalogue/menuHtml/"]
${KITCHEN_APPLIANCES_LINK}          xpath=//a[contains(normalize-space(.),'Кухонная техника')]
${REFRIGERATORS_LINK}               xpath=//a[contains(normalize-space(.),'Холодильники')]
${FIRST_PRODUCT_BUY_BUTTON}         xpath=//button[@data-catalogue_id="114" and contains(@class, 'buy-button')]
${CONFIRM_ORDER_BUTTON}             xpath=//button[contains(@class, "button_theme_basket-accessories-confirm")]
${CART_LINK}                        xpath=//a[@data-key="YmFza2V0LWxpbms"]
${CHECKOUT_BUTTON_IN_CART}          xpath=//button[contains(@class, 'checkout-button')]
${CART_ITEM_IMAGE}                  xpath=//img[contains(@class, 'image__adaptive') and contains(@alt, 'basket_image')]
${LOGO_ITEM_IMAGE}                  xpath=//div[contains(@class, "header__logo")]


*** Keywords ***
Precondition: Open Browser CHROME
    [Documentation]    Открыть браузер
    Open Browser    url=${SITE}    browser=${BROWSER}
    Maximize Browser Window

Poscondition: Close Browser
    [Documentation]    Закрыть браузер
    Close Browser

Go To Catalog
    [Documentation]    Перейти в каталог
    Wait Until Element Is Visible    ${CATALOG_LINK}    timeout=10s
    Click Element    ${CATALOG_LINK}

Hover Over Kitchen Appliances
    [Documentation]    Навести курсор на "Кухонная техника"
    Wait Until Element Is Visible    ${KITCHEN_APPLIANCES_LINK}    timeout=10s
    Mouse Over    ${KITCHEN_APPLIANCES_LINK}

Go To Refrigerators
    [Documentation]    Перейти в категорию "Холодильники"
    Wait Until Element Is Visible    ${REFRIGERATORS_LINK}    timeout=10s
    Click Element    ${REFRIGERATORS_LINK}

Add First Product To Cart
    [Documentation]    Добавить первый товар в корзину
    Wait Until Element Is Visible    ${FIRST_PRODUCT_BUY_BUTTON}    timeout=5s
    Click Element    ${FIRST_PRODUCT_BUY_BUTTON}

Confirm Order
    [Documentation]    Подтвердить выбор товара
    Wait Until Element Is Visible    ${CONFIRM_ORDER_BUTTON}    timeout=10s
    Click Element    ${CONFIRM_ORDER_BUTTON}

Go To Cart
    [Documentation]    Перейти в корзину
    Wait Until Element Is Visible    ${CART_LINK}    timeout=10s
    Click Element    ${CART_LINK}

Check Cart Contains Product Image
    [Documentation]    Проверить, что в корзине есть картинка товара
    Wait Until Element Is Visible    ${CART_ITEM_IMAGE}    timeout=10s
    Element Should Be Visible    ${CART_ITEM_IMAGE}

Check Cart Is Not Empty
    [Documentation]    Проверить, что корзина не пустая
    Wait Until Element Is Visible    ${CHECKOUT_BUTTON_IN_CART}    timeout=10s
    Element Should Be Visible    ${CHECKOUT_BUTTON_IN_CART}

Go To Main
    [Documentation]    Перейти на главную страницу сайта
    Wait Until Element Is Visible    ${LOGO_ITEM_IMAGE}      timeout=10s
    Click Element    ${LOGO_ITEM_IMAGE}
