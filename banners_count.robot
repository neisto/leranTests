*** Settings ***
Documentation    Набор тестов для подсчета количества баннеров на главной сайта LERAN.pro
Resource    leran.resource
Test Setup    Precondition: Open Browser CHROME
Test Teardown    Poscondition: Close Browser


*** Variables ***
${BANNER_DEFAULT}    6
${LONG_BANNER}    xpath=//li[contains(@class, 'banner__item')]
${NEXT_BANNER}    xpath=//a[contains(@class, 'carousel__nav_button_next')]
${CITYES}    css=span.link__text
${INPUT_CITYES}    xpath=//input[contains(@class, 'input-with-clear__inner')]


*** Test Cases ***
Banner Check
    [Documentation]    Открыть сайт, пролистать баннеры, сменить город
    Go To Main
    Simple Banner Check
    Go To Main
    City Change Samara
    Simple Banner Check


*** Keywords ***
Simple Banner Check
    [Documentation]    Простая проверка слайдера путем прокликивания всех баннеров
    Wait Until Element Is Visible    ${LONG_BANNER}    timeout=10s
    Sleep    1s
    ${clicks_needed}=    Evaluate    ${BANNER_DEFAULT} - 1
    FOR    ${index}    IN RANGE    ${clicks_needed}
        ${click_status}=    Run Keyword And Return Status    Click Element    ${NEXT_BANNER}
        IF    not ${click_status}    BREAK
        Sleep    0.5s
        Log    Сделан клик ${index + 1} из ${clicks_needed}
    END
    Log    Проверка завершена

City Change Samara
    [Documentation]    Смена города на г. Самара через JavaScript
    Wait Until Element Is Visible    ${CITYES}    timeout=5s
    Click Element    ${CITYES}
    Sleep    1s
    Wait Until Element Is Visible    ${INPUT_CITYES}    timeout=5s
    Input Text    ${INPUT_CITYES}    Самара
    Sleep    3s
    ${RESULT}=    Execute JavaScript
    ...    const selector = 'span.region-select__city[data-region_id="292"]';
    ...    const el = document.querySelector(selector);
    ...    if (!el) {
    ...    console.warn('Не найден элемент:', selector);
    ...    return 'Элемент не найден';
    ...    }
    ...    el.scrollIntoView({ block: 'center', behavior: 'instant' });
    ...    el.dispatchEvent(new MouseEvent('click', { bubbles: true, cancelable: true, view: window }));
    ...    console.log('Кликнул:', el);
    ...    return 'Клик выполнен';
    Log    Результат JS: ${RESULT}
    Sleep    2s
