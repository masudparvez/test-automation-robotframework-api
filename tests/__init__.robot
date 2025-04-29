*** Settings ***
Variables    config.yaml

Library    RequestsLibrary

Suite Setup    Set session

*** Keywords ***
Set session
    RequestsLibrary.Create Session    alias=posts    url=${api_base_url}
