*** Settings ***
Documentation     These tests verify that all keywords are working correctly
...               and displaying the expected exception message.
Suite Setup       Suite Setup
Suite Teardown    Suite Teardown
Library           ../Mainframe3270/    run_on_failure_keyword=None
Library           Dialogs
Library           OperatingSystem
Library           String
Library           ./utils.py
Resource          mainframe_variables.robot
*** Test Cases ***
CRIS3: Customer Records Information System 3 / Service Order System: AB
    ${read_env_title}    Read    19    013    41
    Should Be Equal As Strings    ${WELCOME_TITLE}    ${read_env_title}
    Write Bare    ${WRITE_TEXT}
    Take Screenshot
    Send Enter
    Write Bare    ${ENV_USERNAME}
    Move Next Field
    Write Bare    ${ENV_PASSWORD}
    Take Screenshot
    Send Enter
    Write Bare    ${SELECT_NEWS}
    Take Screenshot
    Send Enter

CRIS SS: Customer Records Information System Special Services
    Write Bare    /for cris
    Send Enter
    ${read_app_loginTitle}    Read    17    031    35
    Should Be Equal As Strings    ${CRIS_APP_LOGINPAGE}    ${read_app_loginTitle}
    Take Screenshot
    Write Bare    ${APP_USERNAME}
    Write Bare    ${APP_PASSWORD}
    Take Screenshot
    Send Enter
    ${read_app_Title}    Read    01    027    13
    Should Be Equal As Strings    ${CRIS_APP_TITLE}    ${read_app_Title}
    Take Screenshot
    Send PF    1
    Sleep    5s
    ${read_app_loginTitle}    Read    17    031    35
    Should Be Equal As Strings    ${CRIS_APP_LOGINPAGE}    ${read_app_loginTitle}
    Take Screenshot

InstallOrder
    Write Bare    ${APP_USERNAME}
    Write Bare    ${APP_PASSWORD}
    Take Screenshot
    Send Enter
    ${read_app_Title}    Read    01    027    13
    Should Be Equal As Strings    ${CRIS_APP_TITLE}    ${read_app_Title}
    Write Bare in Position    in    23    032
    Send Enter
    Comment    Enter NAM Details
    ${BILLING_NAME}=  evaluate  utils.billingName()  modules=utils
    Write Bare in Position    ${BILLING_NAME}    04    006
    Write Bare in Position    ${SA_HOUSE_No}    05    012
    Write Bare in Position    ${sa_area}    05    022
    Write Bare in Position    ${sa_city}    05    041
    Write Bare in Position    ${sa_PINCODE}    05    064
    Write Bare in Position    ${IN_KEY}    23    007
    Delete Field    23    047
    Comment    delete start
    Send Enter
    sleep    5s
    Write Bare in Position    ${IN_SVC}    08    007
    Send Enter
    sleep    5s
    Send Enter
    Write Bare in Position    ${No_Number_Listed}    01    035
    Write Bare in Position    ${Listing_Type}    08    004
    Send Enter
    Send Enter
    Write Bare in Position    ${bus_type}    07    011
    Send Enter
    sleep    10s
    Send PF    9
    Take Screenshot
    Send Enter
    sleep    5s
    Send Enter
    Write Bare in Position    ${add_s&e1}    09    002
    Write Bare in Position    ${add_s&e2}    11    002
    Write Bare in Position    ${DIR}    21    028
    Send Enter
    Send Enter
    Write Bare in Position    ${BILL_CHARGE}    08    007
    Write Bare in Position    ${BILL_CHARGE}    08    023
    Send Enter
    Send Enter
    Send Enter
    Take Screenshot
    ${KEY_PHONE_No}=  evaluate  utils.telephone()  modules=utils
    Write Bare in Position    ${KEY_PHONE_No}    01    004
    ${REQUEST_DATE}=  evaluate  utils.requestDate()  modules=utils
    ${DUE_DATE}=  evaluate  utils.dueDate()  modules=utils
    Write Bare in Position    ${REQUEST_DATE}    07    012
    Write Bare in Position    ${DUE_DATE}    07    027
    Delete Field    09    013
    Write Bare in Position    ${INSTALL}    09    11
    Write Bare in Position    ${FIRST_NAME}    10    007
    Write Bare in Position    ${PHONE_NO}    10    038
    Send Enter
    Take Screenshot
    Send Enter
    Take Screenshot
    sleep    5s
    Delete Field    23    047
    Delete Field    23    079
    Write Bare in Position    sor    23    030
    Send Enter
    Comment    Need to verify Assigned status
    Take Screenshot
    Write Bare in Position    com    23    030
    Send Enter
    Write Bare in Position    rmk    23    047
    Send Enter
    Write Bare in Position    ${DUE_DATE}    21    007
    Write Bare in Position    ${COMPLETION_ID}    21    023
    Write Bare in Position    ${COMPLETE_TIME}    21    034
    Write Bare in Position    ${COMPLETION_CK}    21    048
    Send Enter
    Take Screenshot
    sleep    5s
    Delete Field    23    047
    Delete Field    23    079
    Write Bare in Position    sor    23    030
    Send Enter
    ${read_order_status}    Read    06    030    9
    Should Be Equal As Strings    ${ORDER_STATUS}    ${read_order_status}

    sleep    10s
    Take Screenshot




    Send PF    1
    Sleep    5s
    ${read_app_loginTitle}    Read    17    031    35
    Should Be Equal As Strings    ${CRIS_APP_LOGINPAGE}    ${read_app_loginTitle}
    Take Screenshot
    sleep    10s
*** Keywords ***
Suite Setup
    Open Connection    ${HOST}
    Create Directory    ${FOLDER}
    Empty Directory    ${FOLDER}
    Set Screenshot Folder    ${FOLDER}
    Change Wait Time    0.4
    Change Wait Time After Write    0.4
    Sleep    3s

Suite Teardown
    Close Connection
    Sleep    1s
    # Verify String Not Found
    # \ \ \ \ [Arguments] \ \ \ ${keyword} \ \ \ ${string} \ \ \ ${ignore_case}=${False}
    # \ \ \ \ ${expected_error} \ \ \ Set Variable \ \ \ The string "${string}" was not found
    # \ \ \ \ Run Keyword And Expect Error \ \ \ ${expected_error} \ \ \ ${keyword} \ \ \ ${string} \ \ \ ignore_case=${ignore_case}
    # Verify String Not Found In List
    # \ \ \ \ [Arguments] \ \ \ ${keyword} \ \ \ ${string_list} \ \ \ ${string_position} \ \ \ ${ignore_case}=${False}
    # \ \ \ \ ${not_found_string} \ \ \ Set Variable If \ \ \ ${ignore_case}==${False} \ \ \ ${string_list[${${string_position}-1}]} \ \ \ ${string_list[${${string_position}-1}].lower()}
    # \ \ \ \ ${expected_error} \ \ \ Set Variable \ \ \ The string "${not_found_string}" was not found
    # \ \ \ \ Run Keyword And Expect Error \ \ \ ${expected_error} \ \ \ ${keyword} \ \ \ ${string_list} \ \ \ ignore_case=${ignore_case}
    # Verify List Not Found
    # \ \ \ \ [Arguments] \ \ \ ${keyword} \ \ \ ${list} \ \ \ ${ignore_case}=${False}
    # \ \ \ \ ${expected_error} \ \ \ Set Variable \ \ \ The strings "${list}" were not found
    # \ \ \ \ Run Keyword And Expect Error \ \ \ EQUALS: ${expected_error} \ \ \ ${keyword} \ \ \ ${list} \ \ \ ignore_case=${ignore_case}
    # Verify Pattern Not Found
    # \ \ \ \ [Arguments] \ \ \ ${keyword} \ \ \ ${string} \ \ \ ${ignore_case}=${False}
    # \ \ \ \ ${not_found_string} \ \ \ Set Variable If \ \ \ ${ignore_case}==${False} \ \ \ ${string} \ \ \ ${string.lower()}
    # \ \ \ \ ${expected_error} \ \ \ Set Variable \ \ \ No matches found for "${not_found_string}" pattern
    # \ \ \ \ IF \ \ \ ${ignore_case}
    # \ \ \ \ \ \ \ \ Run Keyword And Expect Error \ \ \ ${expected_error} \ \ \ ${keyword} \ \ \ ${string} \ \ \ ignore_case=${ignore_case}
    # \ \ \ \ ELSE
    # \ \ \ \ \ \ \ \ Run Keyword And Expect Error \ \ \ ${expected_error} \ \ \ ${keyword} \ \ \ ${string}
    # \ \ \ \ END
    # Verify String Does Not Appear X Times
    # \ \ \ \ [Arguments] \ \ \ ${keyword} \ \ \ ${string} \ \ \ ${wrong_number_of_times} \ \ \ ${right_number_of_times} \ \ \ ${ignore_case}=${False}
    # \ \ \ \ ${expected_error} \ \ \ Set Variable \ \ \ The string "${string}" was not found "${wrong_number_of_times}" times, it appears "${right_number_of_times}" times
    # \ \ \ \ Run Keyword And Expect Error \ \ \ ${expected_error} \ \ \ ${keyword} \ \ \ ${TEXT_TO_COUNT} \ \ \ 1 \ \ \ ignore_case=${ignore_case}
    # Verify String Found
    # \ \ \ \ [Arguments] \ \ \ ${keyword} \ \ \ ${string} \ \ \ ${ignore_case}=${False}
    # \ \ \ \ ${expected_error} \ \ \ Set Variable \ \ \ The string "${string}" was found
    # \ \ \ \ Run Keyword And Expect Error \ \ \ ${expected_error} \ \ \ ${keyword} \ \ \ ${string} \ \ \ ignore_case=${ignore_case}
    # Verify List Found
    # \ \ \ \ [Arguments] \ \ \ ${keyword} \ \ \ ${string_list} \ \ \ ${string_position} \ \ \ ${ignore_case}=${False}
    # \ \ \ \ ${expected_error} \ \ \ Set Variable \ \ \ The string "${string_list[${${string_position}-1}]}" was found
    # \ \ \ \ Run Keyword And Expect Error \ \ \ ${expected_error} \ \ \ ${keyword} \ \ \ ${string_list} \ \ \ ignore_case=${ignore_case}
    # Verify Wait Until String
    # \ \ \ \ [Arguments] \ \ \ ${keyword} \ \ \ ${string}
    # \ \ \ \ ${expected_error} \ \ \ Set Variable \ \ \ String "${string}" not found in 5 seconds
    # \ \ \ \ Run Keyword And Expect Error \ \ \ ${expected_error} \ \ \ ${keyword} \ \ \ ${string}
    # Verify Wait Until String With Timeout
    # \ \ \ \ [Arguments] \ \ \ ${keyword} \ \ \ ${string} \ \ \ ${timeout}
    # \ \ \ \ ${expected_error} \ \ \ Set Variable \ \ \ String "${string}" not found in ${timeout} seconds
    # \ \ \ \ Run Keyword And Expect Error \ \ \ ${expected_error} \ \ \ ${keyword} \ \ \ ${string} \ \ \ ${timeout}
