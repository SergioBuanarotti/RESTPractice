*** Settings ***
Library         RequestsLibrary
Library         BuiltIn
Library         Collections
Library         JSONLibrary


*** Variables ***
${path_json}  resources/post_data.json
${pet_id}  ${4}
${pet_name}  doggie
${pet_status}  avialable

&{headers}  content-type=application/json  accept=application/json
&{form_headers}  content-type=application/x-www-form-urlencoded
&{files}  name=ret  status=done

${session_alias}  alias
${base_url}  https://petstore.swagger.io/v2
${pet_uri}  /pet
${pet_uri_id}  ${pet_uri}/${pet_id}
${upload_pet_image_uri}  ${pet_uri_id}/uploadImage

&{get_args}  id=${pet_id}  name=doggie  status=${pet_status}
&{put_args}  id=${pet_id}  name=dog  status=${pet_status}
&{del_post_args}  type=unknown  message=${pet_id}
&{after_post_args}  id=${pet_id}  name=ret  status=done




*** Keywords ***
Prepare pet data
    ${json}  load json from file  resources/post_data.json
    Create session  ${session_alias}  ${base_url}  headers=${headers}
    Post on session  ${session_alias}  ${pet_uri}  json=${json}

Delete Test Data
    Delete on session   ${session_alias}  ${pet_uri_id}
    Delete All Sessions
    ${session_exist}  Session Exists  ${session_alias}
    should be equal   ${session_exist}  ${False}

Prepare json for put
    ${json}  load json from file  resources/post_data.json
    set to dictionary  ${json}  name=dog
    RETURN  ${json}

Check response
    [Arguments]  ${response}  ${status_code}=200  &{args}
    FOR  ${key}  IN  @{args.keys()}
        ${value}  convert to string  ${args["${key}"]}
        ${json_val}  convert to string  ${response.json()["${key}"]}
        should be equal  ${json_val}  ${value}
    END
    Status should be  ${status_code}  ${response}

Check headers
    [Arguments]  ${response}  &{args}
    FOR  ${key}  IN  @{args.keys()}
        ${value}  convert to string  ${args["${key}"]}
        ${head_val}  convert to string  ${response.headers["${key}"]}
        should be equal  ${head_val}  ${value}
    END





