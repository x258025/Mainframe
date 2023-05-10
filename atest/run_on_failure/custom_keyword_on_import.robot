*** Settings ***
Suite Setup       Open Mainframe
Suite Teardown    Close Mainframe
Library           ../../Mainframe3270/    run_on_failure_keyword=Custom Run On Failure Keyword
Library           OperatingSystem
Resource          ../mainframe_variables.robot
*** Variables ***
${CUSTOM_FILE}    ${CURDIR}${/}output.txt


*** Test Cases ***
# Should Run Custom Keyword
#     Cause Error
#     File Should Exist    ${CUSTOM_FILE}
#     [Teardown]    Remove File    ${CUSTOM_FILE}
*** Keywords ***
Open Mainframe
    Open Connection    ${HOST}
    Sleep    3 seconds

# Cause Error
#     Run Keyword And Expect Error    The string "${STRING_NON_EXISTENT}" was not found    Page Should Contain String    ${STRING_NON_EXISTENT}

Custom Run On Failure Keyword
    Create File    ${CUSTOM_FILE}    An error ocurred

Close Mainframe
    Close Connection
    Sleep    1 second
