*** Settings ***
Resource    resources/posts.resource
Resource    resources/json_helper.resource
Library    Collections

*** Test Cases ***
Verify fetch all posts
    ${response}    posts.Fetch all posts
    Should Be True    ${response.status_code}==200
    @{titles}    json_helper.Get values from json response by jsonpath    response_text=${response.text}    jsonpath=$..title
    Collections.List Should Contain Value    ${titles}    sunt aut facere repellat provident occaecati excepturi optio reprehenderit
    Collections.List Should Contain Value    ${titles}    qui est esse

Verify fetch posts by id
    ${response}    posts.Fetch post by id    id=1
    Should Be True    ${response.status_code}==200
    &{json_response}    JSONLibrary.Convert String To Json    ${response.text}
    Should Be Equal As Strings    ${json_response['userId']}    1
    Should Be Equal As Strings    ${json_response['title']}    
    ...    sunt aut facere repellat provident occaecati excepturi optio reprehenderit
    Should Be Equal As Strings    ${json_response['body']}    
    ...    quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto


Verify create post
    &{payload}    Create Dictionary    title=foo    body=bar    userId=1
    ${response}    posts.Create post    payload=&{payload}
    Should Be True    ${response.status_code}==201
    ${json_response}    JSONLibrary.Convert String To Json    ${response.text}
    Should Be Equal As Strings    ${json_response['title']}    foo
    Should Be Equal As Strings    ${json_response['body']}    bar
    Should Be Equal As Strings    ${json_response['userId']}    1

Verify edit post
    ${response}    posts.Fetch post by id    id=1
    &{json_response}    JSONLibrary.Convert String To Json    ${response.text}
    Should Be Equal As Strings    ${json_response['userId']}    1
    Should Be Equal As Strings    ${json_response['title']}    
    ...    sunt aut facere repellat provident occaecati excepturi optio reprehenderit
    Should Be Equal As Strings    ${json_response['body']}    
    ...    quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto

    &{payload}    Create Dictionary    title=foo    body=bar    userId=10
    ${response}    posts.Edit post by id   payload=&{payload}    id=1
    Should Be True    ${response.status_code}==200
    ${json_response}    JSONLibrary.Convert String To Json    ${response.text}
    Should Be Equal As Strings    ${json_response['title']}    foo
    Should Be Equal As Strings    ${json_response['body']}    bar
    Should Be Equal As Strings    ${json_response['userId']}    10

Verify delete post by id
    ${response}    posts.Delete post by id    id=1
    Should Be True    ${response.status_code}==200

Verify status code when looking for unavailable post
    ${response}    posts.Fetch post by id    id=1121212121
    Should Be Equal As Integers    ${response.status_code}    404
