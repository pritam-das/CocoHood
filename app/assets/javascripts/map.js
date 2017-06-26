$(function() {

if($('#map').length) {


    var lat = parseFloat($('#map').attr('data-parameter1'));
    var lng = parseFloat($('#map').attr('data-parameter2'));
    console.log(lat);
    console.log(lng);
    var userlocation = {lat: lat, lng: lng};
    console.log(userlocation);

    var map = new google.maps.Map(document.getElementById('map'), {
      zoom: 15,
      center: userlocation
    });

    var marker = new google.maps.Marker({
      position: userlocation,
      map: map,
      title: 'User location',
      label: 'U'
    });
    console.log("done");

};
});
