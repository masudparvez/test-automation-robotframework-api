*** Settings ***
Library    JSONLibrary

*** Keywords ***
Get values from json response by jsonpath
    [Arguments]    ${response_text}    ${jsonpath}
    ${json_response}    JSONLibrary.Convert String To Json    ${response_text}
    @{titles}    JSONLibrary.Get Value From Json    ${json_response}    ${jsonpath}
    RETURN    ${titles}

    