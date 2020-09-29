var isoLanguage = 'en';

// If the URL has a search string, then set the initial language alternative to something other than English
// The local ID needs to be parsed from the search ("?") part of the URL
var localID = location.search;
// ignore the initial "?"
if (localID.length>1)
	{
	isoLanguage=localID.substring(1);
	if (isoLanguage=='en') {document.getElementById("box0").selectedIndex = "0";}
	if (isoLanguage=='nl') {document.getElementById("box0").selectedIndex = "1";}
	if (isoLanguage=='es') {document.getElementById("box0").selectedIndex = "2";}
	redrawLabels(isoLanguage)
	}

function redrawLabels(isoLanguage) {
	if (isoLanguage=='en') {
	$("#boxLabel0").text("Language");
	document.getElementById("pageHeader").innerHTML = "establishmentMeans controlled vocabulary demo";
	document.title = "establishmentMeans";
	}
	if (isoLanguage=='nl') {
	$("#boxLabel0").text("Taal");
	document.getElementById("pageHeader").innerHTML = "establishmentMeans Demonstratiepagina";
	document.title = "establishmentMeans";
	}
	if (isoLanguage=='es') {
	$("#boxLabel0").text("Idioma");
	document.getElementById("pageHeader").innerHTML = "Página de demostración de establishmentMeans";
	document.title = "establishmentMeans";
	}
}

function setStatusOptions(isoLanguage) {

        // send query to endpoint
        $.ajax({
            type: 'GET',
            url: 'https://heardlibrary.github.io/digital-scholarship/lod/json_ld_test/establishmentMeans.jsonld',
            headers: {
                Accept: 'application/sparql-results+json'
            },
            success: function(returnedJson) {
				text = ''
				data = returnedJson['@graph']
				for (i = 0; i < data.length; i++) {
					labels = data[i]['skos:prefLabel']
					for (j = 0; j < labels.length; j++) {
						if (isoLanguage==labels[j]['@language']) {
							value = labels[j]['@value']
							text = text + value + '<br/>'
							}
						}
					definitions = data[i]['skos:definition']
					for (j = 0; j < definitions.length; j++) {
						if (isoLanguage==definitions[j]['@language']) {
							value = definitions[j]['@value']
							text = text + 'Definition: ' + value + '<br/>'
							}
						}
					if (data[i]['rdf:value']) {
						cv_string = data[i]['rdf:value']
						text = text + 'Use this value with dwc:establishmentMeans : ' + cv_string + '<br/>'
						}

					if (data[i]['@type'] == 'http://www.w3.org/2004/02/skos/core#Concept') {
						iri = data[i]['@id']
						text = text + 'Use this value with dwciri:establishmentMeans : ' + iri + '<br/>'
						}
					text += '<br/>'
					}
				$("#div1").html(text);
			}
        });

	}

$(document).ready(function(){
    
	// fires when there is a change in the language dropdown
	$("#box0").change(function(){
			var isoLanguage= $("#box0").val();
			redrawLabels(isoLanguage)
			setStatusOptions(isoLanguage);
			$("#div1").html('');
	});

	// Main routine
	setStatusOptions(isoLanguage);

});

