*** Settings ***
Variables    config.yaml

Library    RequestsLibrary

*** Keywords ***
Fetch all posts
    ${response}    RequestsLibrary.GET On Session    alias=posts    url=/posts
    RETURN    ${response}

Fetch post by id
    [Arguments]    ${id}
    ${response}    RequestsLibrary.GET On Session    alias=posts    url=/posts/${id}    expected_status=any
    RETURN    ${response}

Create post
    [Arguments]    ${payload}
    &{headers}    Create Dictionary    Content-type=application/json; charset=UTF-8
    ${response}    RequestsLibrary.POST On Session    alias=posts    url=/posts    json=${payload}    headers=${headers}
    RETURN    ${response}

Delete post by id
    [Arguments]    ${id}
    ${response}    RequestsLibrary.DELETE On Session    alias=posts    url=/posts/${id}    expected_status=any
    RETURN    ${response}

Edit post by id
    [Arguments]    ${payload}    ${id}
    &{headers}    Create Dictionary    Content-type=application/json; charset=UTF-8
    ${response}    RequestsLibrary.PUT On Session    alias=posts    url=/posts/${id}    json=${payload}    headers=${headers}    expected_status=any
    RETURN    ${response}