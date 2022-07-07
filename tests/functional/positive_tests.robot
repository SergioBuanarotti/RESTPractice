*** Settings ***
Library         RequestsLibrary

*** Variables ***
${auth}  {"Authorization": "Bearer 12"}
*** Test Cases ***

get
    ${auth}  evaluate  ${auth}
    ${response}  get  http://httpbin.org/bearer  headers=${auth}
    log to console  ${response.headers}
    log to console  ${response.json()}
    log to console  ${response.status_code}
