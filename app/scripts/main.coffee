box = PUBNUB.$ 'box'
input = PUBNUB.$ 'input'
login = PUBNUB.$ 'login'
logout = PUBNUB.$ 'logout'
timeLeft = PUBNUB.$ 'time-left'
time = 60
interval = null
channel = 'chat'
authKey = PUBNUB.uuid()
pubnub = PUBNUB.init
  publish_key: 'pub-c-4268517d-1e7a-4bdd-8037-090a3c76a1f0'
  subscribe_key: 'sub-c-4c15a542-ced1-11e2-b70f-02ee2ddab7fe'
  auth_key: authKey
  origin: 'pam-beta.pubnub.com'

alternate = false
addMessage = (message) ->
  box.innerHTML = "<span class='msg'>" + ('' + message).replace(/[<>]/g, '') + '</span><br>' + box.innerHTML

pubnub.subscribe
  channel: channel
  callback: (text) ->
    addMessage text

PUBNUB.bind 'keyup', input, (e) ->
  if e.keyCode is 13 or e.charCode is 13
    pubnub.publish
      channel: channel
      message: input.value
      x: (input.value = '')
      error: (message) ->
        if message and message.status is 403
          addMessage "[Access Denied] Please press Login to access chat"

addClass = (el, name) ->
  el.className += "#{name}"

removeClass = (el, name) ->
  el.className = el.className.replace name, ''

pubnub.publish
  channel: 'authentication'
  message: JSON.stringify
    uuid: authKey
    action: 'presence'

doLogin = (e) ->
  login.disabled = true
  login.value = "Logging In..."
  logout.value = "Logout"
  pubnub.publish
    channel: 'authentication'
    message: JSON.stringify
      action: 'login'
      authKey: authKey

doLogout = (e) ->
  logout.disabled = true
  logout.value = "Logging Out..."
  login.value = "Login"
  pubnub.publish
    channel: 'authentication'
    message: JSON.stringify
      action: 'logout'
      authKey: authKey

pubnub.subscribe
  channel: authKey
  callback: (message) ->
    message = JSON.parse message

    if message.action is 'login'
      login.disabled = false
      if message.success is true
        removeClass logout, "hidden"
        removeClass login, "slideUp"
        addClass logout, "slideUp"
        addClass login, "hidden"

        # Add timer for the user
        time = 60
        count = () ->
          time--
          timeLeft.innerHTML = "You have #{time} seconds left..."
          if time is 0
            doLogout({})
            clearInterval interval
        interval = setInterval count, 1000
      else
        login.value = "Error..."
        reset = () ->
          login.value = "Login"
        setTimeout reset, 3000
    else if message.action is 'logout'
      logout.disabled = false
      if message.success is true
        addClass login, "slideUp"
        addClass logout, "hidden"
        removeClass login, "hidden"
        removeClass logout, "slideUp"
        clearInterval interval
        timeLeft.innerHTML = ""
      else
        logout.value = "Error..."
        reset = () ->
          logout.value = "Login"
        setTimeout reset, 3000
  connect: (event) ->
    PUBNUB.bind 'click', login, doLogin
    PUBNUB.bind 'click', logout, doLogout
