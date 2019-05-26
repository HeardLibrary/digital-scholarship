// Important note: There is a certain amount of sloppiness that is tolerated by the fact that the jQuery functions
// that handle the XML returned from AJAX strips off the language tags that the SPARQL endpoint sends in the query
// results.  This means that handling the results is easier if the language tags aren't desired (which they usually 
// arent).  However, if they were desired, they would have to be generated and attached to the literals.  Also,
// if a version of this program were created where the queries requested application/sparql-results+json instead of 
// XML one would need to pay attention to whether the results included language tags or not.  The current (2016-11) 
// Heard Library SPARQL endpoint only supports XML results, but in the future cleaner code might result if the 
// program were converted to using JSON results.

var isoLanguage = 'en';

// If the URL has a search string, then set the initial language alternative to something other than English
// The local ID needs to be parsed from the search ("?") part of the URL
var localID = location.search;
// ignore the initial "?"
if (localID.length>1)
	{
	isoLanguage=localID.substring(1);
	if (isoLanguage=='en') {document.getElementById("box0").selectedIndex = "0";}
	if (isoLanguage=='pt') {document.getElementById("box0").selectedIndex = "1";}
	if (isoLanguage=='de') {document.getElementById("box0").selectedIndex = "2";}
	if (isoLanguage=='es') {document.getElementById("box0").selectedIndex = "3";}
	if (isoLanguage=='zh-hans') {document.getElementById("box0").selectedIndex = "4";}
	if (isoLanguage=='zh-hant') {document.getElementById("box0").selectedIndex = "5";}
	redrawLabels(isoLanguage)
	}

function redrawLabels(isoLanguage) {
	if (isoLanguage=='en') {
	$("#boxLabel0").text("Language");
	$("#boxLabel1").text("Status");
	document.getElementById("pageHeader").innerHTML = "Occurrence Status picklist demo page";
	document.title = "Occurrence status";
	}
	if (isoLanguage=='pt') {
	$("#boxLabel0").text("Língua");
	$("#boxLabel1").text("Status");
	document.getElementById("pageHeader").innerHTML = "Página de demonstração de opções de ocorrência";
	document.title = "Status da ocorrência";
	}
	if (isoLanguage=='de') {
	$("#boxLabel0").text("Sprache");
	$("#boxLabel1").text("Status");
	document.getElementById("pageHeader").innerHTML = "Auftreten Status Auswahlliste Demo Seite";
	document.title = "Auftretensstatus";
	}
	if (isoLanguage=='es') {
	$("#boxLabel0").text("Idioma");
	$("#boxLabel1").text("Estado");
	document.getElementById("pageHeader").innerHTML = "Página de demostración de selección de estado de ocurrencia";
	document.title = "Estado de ocurrencia";
	}
	if (isoLanguage=='zh-hans') {
	$("#boxLabel0").text("语言");
	$("#boxLabel1").text("状态");
	document.getElementById("pageHeader").innerHTML = "发生状态选择列表演示页面";
	document.title = "发生状态";
	}
	if (isoLanguage=='zh-hant') {
	$("#boxLabel0").text("語言");
	$("#boxLabel1").text("狀態");
	document.getElementById("pageHeader").innerHTML = "發生狀態選擇列表演示頁面";
	document.title = "發生狀態";
	}
}

function setStatusOptions(isoLanguage) {
	if (isoLanguage=='en') {languageTag='en';}
	if (isoLanguage=='pt') {languageTag='pt';}
	if (isoLanguage=='de') {languageTag='de';}
	if (isoLanguage=='es') {languageTag='es';}
	if (isoLanguage=='zh-hans') {languageTag='zh-hans';}
	if (isoLanguage=='zh-hant') {languageTag='zh-hant';}

	// start the status dropdown over with "Select/Selecionar/Wählen" as the first option
	$("#box1 option:gt(0)").remove();
	if (isoLanguage=='en') {$("#box1 option").text("(Select)");}
	if (isoLanguage=='pt') {$("#box1 option").text("(Selecionar)");}
	if (isoLanguage=='de') {$("#box1 option").text("(Wählen)");}
	if (isoLanguage=='es') {$("#box1 option").text("(Seleccionar)");}
	if (isoLanguage=='zh-hans') {$("#box1 option").text("(选择)");}
	if (isoLanguage=='zh-hant') {$("#box1 option").text("(選擇)");}

	// create URI-encoded query string
        var string = 'PREFIX skos: <http://www.w3.org/2004/02/skos/core#>'
                    +'SELECT DISTINCT ?label ?def ?term WHERE {'
                    +'?term <http://www.w3.org/2000/01/rdf-schema#isDefinedBy>'
                    +'<http://rs.tdwg.org/cv/status/>.'
                    +'?term skos:prefLabel ?label.'
                    +'?term skos:definition ?def.'
                    +"FILTER (lang(?label)='"+isoLanguage+"')"
                    +"FILTER (lang(?def)='"+isoLanguage+"')"
                    +'}'
                    +'ORDER BY ASC(?label)';
	var encodedQuery = encodeURIComponent(string);

        // send query to endpoint
        $.ajax({
            type: 'GET',
            url: 'https://sparql.vanderbilt.edu/sparql?query=' + encodedQuery,
            headers: {
                Accept: 'application/sparql-results+xml'
            },
            success: parseXml
        });

	}

// converts nodes of an XML object to text. See http://tech.pro/tutorial/877/xml-parsing-with-jquery
// and http://stackoverflow.com/questions/4191386/jquery-how-to-find-an-element-based-on-a-data-attribute-value

function parseXml(xml) {
    // done searching, so hide the spinner icon
    $('#searchSpinner').hide();
    //step through each "result" element
    $(xml).find("result").each(function() {

        // pull the "binding" element that has the name attribute of "label"
        $(this).find("binding[name='label']").each(function() {
            label=$(this).find("literal").text();
        });
        
	// pull the "binding" element that has the name attribute of "term"
	$(this).find("binding[name='term']").each(function() {
	    value=$(this).find("uri").text();
	});
	// add the new information to the dropdown list
        $("#box1").append("<option value='"+value+"'>"+label+'</option>');
    });
}

$(document).ready(function(){
		
	// not searching initially, so hide the spinner icon
	$('#searchSpinner').hide();
    
	// fires when there is a change in the language dropdown
	$("#box0").change(function(){
			// searching, so show the spinner icon
			$('#searchSpinner').show();
			var isoLanguage= $("#box0").val();
			redrawLabels(isoLanguage)
			setStatusOptions(isoLanguage);
	});

	// fires when there is a change in the province dropdown
	$("#box1").change(function(){
			var selection = $("#box1").val();
			$("#div1").text(selection);
	});

	// Main routine: execute SPARQL queries to get values and add them to the select options
	setStatusOptions(isoLanguage);

});


