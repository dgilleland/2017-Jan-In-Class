function about() {
  var info = {
    userName: '',
    surName: '',
    fullName: '',
    email: '',
    course: {
      fullName: '',
      shortName: ''
    }
  }
  var urlParams = new URLSearchParams(window.location.search);
  if(urlParams.has('un')) info.userName = urlParams.get('un');
  if(urlParams.has('sn')) info.surName = urlParams.get('sn');
  if(urlParams.has('fn')) info.fullName = urlParams.get('fn');
  if(urlParams.has('em')) info.email = urlParams.get('em');
  if(urlParams.has('c_fn')) info.course.fullName = urlParams.get('c_fn');
  if(urlParams.has('c_sn')) info.course.shortName = urlParams.get('c_sn');
  console.log(info);
}

about();