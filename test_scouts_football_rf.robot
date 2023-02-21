*** Settings ***
Library    SeleniumLibrary
Documentation    Suite description #automated tests for scout website

*** Variables ***
${LOGIN URL}    https://scouts.futbolkolektyw.pl/en
${BROWSER}  Chrome
${SIGNINBUTTON}  //*[@type='submit']
${LOGIN FIELD}  //*[@id='login']
${PASSWORD FIELD}   //input[@type='password']
${PLAYERS BUTTON}  //*[text()='Players']
${LOGIN ERROR}  //*/form/div/div[1]/div[3]/span
${ADD MATCH URL}   https://scouts.futbolkolektyw.pl/en/players/62f2bce6159aa3d4fa18f4b2/matches/add
${ADD PLAYER BUTTON}    //div[3]/div[2]/div/div/a/button/span[1]
${NAME FIELD}   //input[@name='name']
${SURNAME FIELD}    //input[@name='surname']
${AGE FIELD}    //input[@name='age']
${MAINPOSITION FIELD}   //input[@name='mainPosition']
${SUBMIT PLAYER BUTTON}     //*[@id="__next"]/div[1]/main/div[2]/form/div[3]/button[1]/span[1]
${PLAYER ADDED}  //*[text()="John Doe"]
${SIGN OUT BUTTON}  //*[text()='Sign out']
${LANGUAGE CHANGE}  //*/ul[2]/div[1]/div[2]/span
${TEAM NAME}    //*[@name='myTeam']
${TEAM SCORE}   //*[@name='myTeamScore']
${ENEMY TEAM NAME}  //*[@name='enemyTeam']
${ENEMY TEAM SCORE}  //*[@name='enemyTeamScore']
${MATCH DATE}   //input[@type='date']
${SUBMIT MATCH}  //form/div[3]/button[1]/span[1]

*** Test Cases ***
Login to the system with correct credentials
    Open login page
    Type in email
    Type in password
    Click on the Submit button
    Assert dashboard
    [Teardown]  Close Browser
Login to the system with incorrect credentials
    Open login page
    Type in email
    Type in incorrect password
    Click on the Submit button
    Assert login error
    [Teardown]  Close Browser
Add a player
    Open login page
    Type in email
    Type in password
    Click on the Submit button
    Click on the Add Player button
    Type in name
    Type in surname
    Type in age
    Type in main position
    Click on the Submit Player button
    Assert player added
    [Teardown]  Close Browser
Sign out of the system
    Open login page
    Type in email
    Type in password
    Click on the Submit button
    Click on the Sign out button
    [Teardown]  Close Browser
Change language
    Open login page
    Type in email
    Type in password
    Click on the Submit button
    Click on Change language button
    Assert Language Change
    [Teardown]  Close Browser
Add a match
    Open login page
    Type in email
    Type in password
    Click on the Submit button
    Open add match page
    Type in my team name
    Type in my team score
    Type in enemy team name
    Type in enemy team score
    Type in match date
    Click submit match
    [Teardown]  Close Browser

*** Keywords ***
Open login page
    Open Browser    ${LOGIN URL}    ${BROWSER}
    Title Should Be    Scouts panel - sign in
Open add match page
     Wait Until Element Is Visible    ${PLAYERS BUTTON}
     Go To    ${ADD MATCH URL}
Type in email
    Input Text    ${LOGIN FIELD}    user02@getnada.com
Type in password
    Input Text    ${PASSWORD FIELD}     Test-1234
Type in incorrect password
    Input Text    ${PASSWORD FIELD}  Test
Type in name
    Wait Until Element Is Visible   ${NAME FIELD}
    Input Text      ${NAME FIELD}   John
Type in surname
    Input Text    ${SURNAME FIELD}  Doe
Type in age
    Input Text    ${AGE FIELD}  01-02-2012
Type in main position
    Input Text    ${MAINPOSITION FIELD}  Goalkeeper
Type in my team name
    Wait Until Element Is Visible   ${TEAM NAME}
    Input Text    ${TEAM NAME}  First
Type in my team score
    Input Text    ${TEAM SCORE}  5
Type in enemy team name
    Input Text    ${ENEMY TEAM NAME}  Second
Type in enemy team score
    Input Text    ${ENEMY TEAM SCORE}  3
Type in match date
    Input Text    ${MATCH DATE}  02-02-2023
Click submit match
    Click Element    ${SUBMIT MATCH}
Click on the Submit button
    Click Element    ${SIGNINBUTTON}
Click on the Add Player button
    Wait Until Element Is Visible    ${ADD PLAYER BUTTON}
    Click Element    ${ADD PLAYER BUTTON}
Click on the Submit Player button
    Click Element    ${SUBMIT PLAYER BUTTON}
Click on the Sign out button
    Wait Until Element Is Visible   ${SIGN OUT BUTTON}
    Click Element   ${SIGN OUT BUTTON}
Click on Change language button
    Wait Until Element Is Visible   ${LANGUAGE CHANGE}
    Click Element   ${LANGUAGE CHANGE}
Assert dashboard
    Wait Until Element Is Visible    ${PLAYERS BUTTON}
    Title Should Be    Scouts panel
    Capture Page Screenshot    dashboard.png
Assert login error
    Wait Until Element Is Visible    ${LOGIN ERROR}
    Element Text Should Be    ${LOGIN ERROR}    Identifier or password invalid.
    Capture Page Screenshot    loginerror.png
Assert player added
    Wait Until Element Is Visible    ${PLAYER ADDED}
    Element Text Should Be   ${PLAYER ADDED}    John Doe
    Capture Page Screenshot    addplayer.png
Assert language change
    Wait Until Element Is Visible    ${LANGUAGE CHANGE}
    Element Text Should Be    ${LANGUAGE CHANGE}    English
    Capture Page Screenshot    languagechange.png
