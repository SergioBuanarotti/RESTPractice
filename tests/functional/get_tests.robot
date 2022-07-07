*** Settings ***
Resource        ../../resources/data.resource

Test Setup  Prepare pet data
Test Teardown  Delete Test Data

*** Test Cases ***
Check get
    ${response}  get on session  ${session_alias}  ${pet_uri_id}
    Check response  ${response}  &{get_args}

Get Pet After Put
    ${json}  Prepare json for put
    Put on session  ${session_alias}  ${pet_uri}  json=${json}
    ${response}  Get on session  ${session_alias}  ${pet_uri_id}
    Check response  ${response}  &{put_args}

Get after post update
    Update session  ${session_alias}  headers=${form_headers}
    Post on session  ${session_alias}  ${pet_uri_id}  data=${files}
    ${response}  Get on session  ${session_alias}  ${pet_uri_id}
    Check response  ${response}  &{after_post_args}

Post Update Pet
    Update session  ${session_alias}  headers=${form_headers}
    ${response}  Post on session  ${session_alias}  ${pet_uri_id}  data=${files}
    Check response  ${response}  &{del_post_args}  code=${response.status_code}

Put Update Pet
    ${json}  Prepare json for put
    ${response}  Put on session  ${session_alias}  ${pet_uri}  json=${json}
    Check response  ${response}  &{put_args}

Delete Pet
    [Teardown]    NO OPERATION
    ${response}  Delete on session  ${session_alias}  ${pet_uri_id}
    Check response  ${response}  &{del_post_args}  code=${response.status_code}
    Delete All Sessions
    ${session_exist}  Session Exists  ${session_alias}
    should be equal   ${session_exist}  ${False}