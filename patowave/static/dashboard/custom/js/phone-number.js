function editSMS(val) {

    axios.defaults.xsrfCookieName = 'csrftoken'
    axios.defaults.xsrfHeaderName = "X-CSRFTOKEN"

    let data = new FormData()
    var number = document.getElementById(`number-sms-${val}`).value
    var whatsapp = document.getElementById(`flexCheckDefault--${val}`).checked

    // Make sure phone number is correct
    if (number.length != 10) {
        return alert('Only 10 characters are allowed')
    }
    if (number.length == 10 && number.startsWith('0') != true) {
        return alert('Your number should start with 0')
    }
    // new number
    document.getElementById(`my-new-number-${val}`).innerText = number

    data.append("val", val)
    data.append("number", number)
    data.append("sms", true)
    data.append("whatsapp", whatsapp)
    axios.post(`/dashboard/phone-details-edit/`, data)
        .then(function(response) {
            // Toast for feedback
            var toastLiveExample = document.getElementById('liveToastSaveChanges')
            var toast = new bootstrap.Toast(toastLiveExample)
            toast.show()
        })
        .catch(function(error) {
            // Toast for feedback - error
            var toastLiveExample = document.getElementById('liveToastNetworkError')
            var toast = new bootstrap.Toast(toastLiveExample)
            toast.show()
        });
}

function deleteNumber(val) {
    axios.defaults.xsrfCookieName = 'csrftoken'
    axios.defaults.xsrfHeaderName = "X-CSRFTOKEN"


    let data = new FormData()

    data.append("val", val)
    axios.post(`/dashboard/phone-details-delete/${val}/`, data)
        .then(function(response) {
            // Toast for feedback
            var toastLiveExample2 = document.getElementById('liveToastDelete')
            var toast = new bootstrap.Toast(toastLiveExample2)
            toast.show()
            document.getElementById(`email-${val}`).hidden = true
        })
        .catch(function(error) {
            // Toast for feedback - error
            var toastLiveExample = document.getElementById('liveToastNetworkError')
            var toast = new bootstrap.Toast(toastLiveExample)
            toast.show()
        });
}