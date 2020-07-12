$(function() {
  return $('#sendaddress_zipcode').jpostal({
    postcode: ['#sendaddress_zipcode'],
    address: {
      '#sendaddress_prefectures': '%3',
      '#sendaddress_municipalitities': '%4',
      '#sendaddress_streetaddress': '%5%6%7',
    },
  });
});