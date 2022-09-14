// function timeSince(date) {
//     var seconds = Math.floor((Date.now() - date));
//     seconds = seconds
//         // alert(seconds / 31536000)

//     var interval = seconds / 31536000;

//     if (interval > 1) {
//         return Math.floor(interval) + " years";
//     }
//     interval = seconds / 2592000;
//     if (interval > 1) {
//         return Math.floor(interval) + " months";
//     }
//     interval = seconds / 86400;
//     if (interval > 1) {
//         return Math.floor(interval) + " days";
//     }
//     interval = seconds / 3600;
//     if (interval > 1) {
//         return Math.floor(interval) + " hours";
//     }
//     interval = seconds / 60;
//     if (interval > 1) {
//         return Math.floor(interval) + " minutes";
//     }
//     return Math.floor(seconds) + " seconds";
// }

// axios({
//         method: 'get',
//         url: '/dashboard/message/all/',
//     })
//     .then(function(response) {
//         var data = response.data.response
//         var content = ``
//         data.map(item => {
//             content += `
//                 <li class="list-group-item list-group-item-action dropdown-notifications-item">
//                     <div class="d-flex">
//                         <div class="flex-shrink-0 me-3">
//                             <div class="avatar">
//                                 <img src="${item[1]}" alt class="w-px-40 h-auto rounded-circle">
//                             </div>
//                         </div>
//                         <div class="flex-grow-1">
//                             <h6 class="mb-1">${item[2]}</h6>
//                             <p class="mb-0"><a href="/dashboard/message/${item[2]}&${item[0]}&${item[5]}/">${item[3].slice(0,50)}...</a></p>
//                             <small class="text-muted">${timeSince(item[4])} ago</small>
//                         </div>
//                         <div class="flex-shrink-0 dropdown-notifications-actions">
//                             <a href="/dashboard/message/${item[2]}&${item[0]}&${item[5]}/" class="dropdown-notifications-read"><span class="badge badge-dot"></span></a>
//                         </div>
//                     </div>
//                 </li>
//                 `
//         })
//         document.getElementById('my-post').innerHTML = content
//             // console.log()
//             // alert('mhh')
//     });