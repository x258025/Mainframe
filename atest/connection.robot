*** Settings ***
Test Teardown     Test Teardown
Resource          mainframe_variables.robot
Library           OperatingSystem
Library           ../Mainframe3270/    ${VISIBLE}
*** Variables ***
${ARGFILE}        ${CURDIR}/resources/argfile.txt
${SESSION_TEMPLATE}    ${CURDIR}/resources/session.template
${TRACE_FILE}     ${CURDIR}/x3270.trace


*** Test Cases ***
Test Connection With Extra Args List
    ${extra_args}=    Create List    -port    23    -trace    -tracefile    ${TRACE_FILE}
    Open Connection    L:${HOST}    extra_args=${extra_args}
    Sleep    0.5 s
    File Should Exist    ${TRACE_FILE}

Test Connection With Argfile
    Open Connection    ${HOST}    extra_args=${ARGFILE}
    Sleep    0.5 s
    File Should Exist    ${TRACE_FILE}

Test Connection From Session File
    ${session_file}=    Create Session File
    Open Connection From Session File    ${SESSION_FILE}

    Wait Field Detected
*** Keywords ***
Create Session File
    ${os_name}=    Evaluate    os.name
    IF    '${os_name}' == 'nt' and ${VISIBLE}
        ${session_file}=    Set Variable    ${CURDIR}/resources/session.wc3270
    ELSE IF    '${os_name}' == 'nt' and not ${VISIBLE}
        ${session_file}=    Set Variable    ${CURDIR}/resources/session.ws3270
    ELSE IF    '${os_name}' == 'posix' and ${VISIBLE}
        ${session_file}=    Set Variable    ${CURDIR}/resources/session.x3270
    ELSE IF    '${os_name}' == 'posix' and not ${VISIBLE}
        ${session_file}=    Set Variable    ${CURDIR}/resources/session.s3270
    END
    Copy File    ${SESSION_TEMPLATE}    ${session_file}
    RETURN    ${session_file}

Test Teardown
    Close Connection
    Sleep    1 second
    Remove File    ${TRACE_FILE}
