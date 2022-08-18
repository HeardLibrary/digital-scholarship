// Important note: There is a certain amount of sloppiness that is tolerated by the fact that the jQuery functions
// that handle the XML returned from AJAX strips off the language tags that the SPARQL endpoint sends in the query
// results.  This means that handling the results is easier if the language tags aren't desired (which they usually 
// arent).  However, if they were desired, they would have to be generated and attached to the literals.  Also,
// if a version of this program were created where the queries requested application/sparql-results+json instead of 
// XML one would need to pay attention to whether the results included language tags or not.  The current (2016-11) 
// Heard Library SPARQL endpoint only supports XML results, but in the future cleaner code might result if the 
// program were converted to using JSON results.

var numResultstoReturn = 500; // the max number of results to return in the SPARQL search query
var numResultsPerPage = 10; // the number of search results per page, for pagination
var isoLanguage = 'en';
var imageHtmlBlob = '';
var done = 'no'

var dynastiesEn = [
	"Tang",
	"Five Dynasties",
	"Northern Song",
	"Southern Song",
	"Liao",
	"Jin",
	"Yuan",
	"Ming",
	"Qing"
];

var dynastiesZh = [
	"唐",
	"五代",
	"北宋",
	"南宋",
	"辽",
	"金",
	"元",
	"明",
	"清"
];

// URIs from the PeriodO ontology http://perio.do/
var dynastiesURI = [
	"<http://n2t.net/ark:/99152/p0fp7wvrjpj>",
	"<http://n2t.net/ark:/99152/p0fp7wv5h26>",
	"<http://n2t.net/ark:/99152/p0fp7wvjvn8>",
	"<http://n2t.net/ark:/99152/p0fp7wv9x7n>",
	"<http://n2t.net/ark:/99152/p0fp7wvw8zq>",
	"<http://n2t.net/ark:/99152/p0fp7wvmghn>",
	"<http://n2t.net/ark:/99152/p0fp7wvvrz5>",
	"<http://n2t.net/ark:/99152/p0fp7wv2s8c>",
	"<http://n2t.net/ark:/99152/p0fp7wvtqp9>"
];

function setProvinceOptions(isoLanguage) {
	if (isoLanguage=='en') {languageTag='zh-latn-pinyin';}
	if (isoLanguage=='zh-hans') {languageTag='zh-hans';}

    // start the province dropdown over with "Any province/任何省份" as the first option
    $("#box1 option:gt(0)").remove();
    $("#box1 option").text("Any province/任何省份");

	// create URI-encoded query string
        var string = 'SELECT DISTINCT ?province WHERE {'
                    +'?site <http://www.geonames.org/ontology#featureCode> <http://www.geonames.org/ontology#S.ANS>.'
                    +'?site <http://rs.tdwg.org/dwc/terms/stateProvince> ?province.'
                    +"FILTER (lang(?province)='"+languageTag+"')"
                    +'}'
                    +'ORDER BY ASC(?province)';
	var encodedQuery = encodeURIComponent(string);

        // send query to endpoint
        $.ajax({
            type: 'GET',
            url: 'https://sparql.vanderbilt.edu/sparql?query=' + encodedQuery,
            headers: {
                Accept: 'application/sparql-results+xml'
            },
            success: parseProvinceXml
        });

	}

function setDynastyOptions(isoLanguage) {
	
	if (isoLanguage=='en') {languageTag='en';}
	if (isoLanguage=='zh-hans') {languageTag='zh-hans';}
	
        $("#box3 option:gt(0)").remove();
	for (i=0;i<dynastiesURI.length;i++)
	    {
	    if (isoLanguage=='en') {labelValue=dynastiesEn[i];}
	    if (isoLanguage=='zh-hans') {labelValue=dynastiesZh[i];}
	    bindingValue=dynastiesURI[i];
	    $("#box3").append("<option value='"+bindingValue+"'>"+labelValue+'</option>');
            }
 	}

function setSiteOptions(provinceSelection,dynastySelection,isoLanguage) {
	if (isoLanguage=='en') {languageTag='en';}
	if (isoLanguage=='zh-hans') {languageTag='zh-hans';}

    // start the site dropdown over with "Any temple/任何寺庙" as the first option
    $("#box2 option:gt(0)").remove();
    $("#box2 option").text("Any temple/任何寺庙");

	// create URI-encoded query string
	var string = "PREFIX time: <http://www.w3.org/2006/time#>"
		    +'SELECT DISTINCT ?siteName WHERE {'
                    +'?site <http://www.geonames.org/ontology#featureCode> <http://www.geonames.org/ontology#S.ANS>.'
        if (provinceSelection != '?province') 
        	{
	        string = string + '?site <http://rs.tdwg.org/dwc/terms/stateProvince> ?provinceTagged.'
	            +'BIND (str(?provinceTagged) AS ?province)'
	            +'FILTER (?province =  '+provinceSelection+')'
	        }
	if (dynastySelection != '?dynasty')
		{
	        string = string +'?site <http://purl.org/dc/terms/temporal> ?interval.'
                    +'?interval time:intervalStartedBy ?startDynasty.'
                    +'?interval time:intervalFinishedBy ?endDynasty.'
                    // target dynasty must be earlier than ?endDynasty
                    +'?endDynasty time:intervalMetBy* '+dynastySelection+'.'
                    //target dynasty must be later than ?startDynasty
                    +dynastySelection+' time:intervalMetBy* ?startDynasty.'

                    // +'?interval <http://www.w3.org/2000/01/rdf-schema#label> ?periodTagged.'
	           // +'BIND (str(?periodTagged) AS ?period)'
	           // +'FILTER (?period =  '+dynastySelection+')'
	        }
                string = string +'?site <http://www.w3.org/2000/01/rdf-schema#label> ?siteTagged.'
                    +"FILTER (lang(?siteTagged)='"+languageTag+"')"
	            +'BIND (str(?siteTagged) AS ?siteName)'
	            +'}'
                +'ORDER BY ASC(?siteName)';

                var encodedQuery = encodeURIComponent(string);
        // send query to endpoint
        $.ajax({
            type: 'GET',
            url: 'https://sparql.vanderbilt.edu/sparql?query=' + encodedQuery,
            headers: {
                Accept: 'application/sparql-results+xml'
            },
            success: parseSiteXml
        });

	}
/*
function setCategoryOptions() {
	// create URI-encoded query string
        var string = "PREFIX Iptc4xmpExt: <http://iptc.org/std/Iptc4xmpExt/2008-02-29/>"+
                    "PREFIX skos: <http://www.w3.org/2004/02/skos/core#>"+
                    'SELECT DISTINCT ?category WHERE {' +
                    "?image Iptc4xmpExt:CVterm ?view." +
                    "?view skos:broader ?featureCategory." +
                    "?featureCategory skos:prefLabel ?category." +
                    '}'
                    +'ORDER BY ASC(?category)';
	var encodedQuery = encodeURIComponent(string);

        // send query to endpoint
        $.ajax({
            type: 'GET',
            url: 'https://sparql.vanderbilt.edu/sparql?query=' + encodedQuery,
            headers: {
                Accept: 'application/sparql-results+xml'
            },
            success: parseCategoryXml
        });

	}
*/
function parseProvinceXml(xml) {
    // done searching, so hide the spinner icon
    $('#searchSpinner').hide();
    //step through each "result" element
    $(xml).find("result").each(function() {

        // pull the "binding" element that has the name attribute of "province"
        $(this).find("binding[name='province']").each(function() {
            bindingValue=$(this).find("literal").text();
            quoteBindingValue='"'+bindingValue+'"';
            $("#box1").append("<option value='"+quoteBindingValue+"'>"+bindingValue+'</option>');
        });
    });
}

function parseSiteXml(xml) {
    // done searching, so hide the spinner icon
    $('#searchSpinner').hide();
    //step through each "result" element
    $(xml).find("result").each(function() {

        // pull the "binding" element that has the name attribute of "siteName"
        $(this).find("binding[name='siteName']").each(function() {
            bindingValue=$(this).find("literal").text();
            quoteBindingValue='"'+bindingValue+'"';
            $("#box2").append("<option value='"+quoteBindingValue+"'>"+bindingValue+'</option>');
        });
    });
}
/*
function parseCategoryXml(xml) {
    // done searching, so hide the spinner icon
    $('#searchSpinner').hide();
    //step through each "result" element
    $(xml).find("result").each(function() {

        // pull the "binding" element that has the name attribute of "category"
        $(this).find("binding[name='category']").each(function() {
            bindingValue=$(this).find("literal").text();
            quoteBindingValue='"'+bindingValue+'"';
            $("#box4").append("<option value='"+quoteBindingValue+"'>"+bindingValue+'</option>');
        });
    });
}
*/

function getImages(buildingURI,tableRow) {

	// create URI-encoded query string
        var string = 'PREFIX ac: <http://rs.tdwg.org/ac/terms/>'
                    +'PREFIX foaf: <http://xmlns.com/foaf/0.1/>'
                    +'SELECT DISTINCT ?thumbURL ?gqURL WHERE {'
                    +"?image foaf:depicts <"+buildingURI+">."
                    +'?image ac:hasServiceAccessPoint ?thumbSap.'
                    +'?thumbSap ac:variant ac:Thumbnail.'
                    +'?thumbSap ac:accessURI ?thumbURL.'
                    +'?image ac:hasServiceAccessPoint ?gqSap.'
                    +'?gqSap ac:variant ac:GoodQuality.'
                    +'?gqSap ac:accessURI ?gqURL.'
                    +'}';
	var encodedQuery = encodeURIComponent(string);
        // send query to endpoint
        $.ajax({
            type: 'GET',
            url: 'https://sparql.vanderbilt.edu/sparql?query=' + encodedQuery,
            headers: {
                Accept: 'application/sparql-results+xml'
            },
//            success: parseImageXml
        })
        .done(function(xml){
	    //step through each "result" element
	    $(xml).find("result").each(function() {
	
		// pull the "binding" element that has the name attribute of "gqURL"
		$(this).find("binding[name='gqURL']").each(function() {
		    tableRow=tableRow+"<a target='_blank' href='"+$(this).find("uri").text() + "'>";
		});
	
		// pull the "binding" element that has the name attribute of "thumbURL"
		$(this).find("binding[name='thumbURL']").each(function() {
		    tableRow=tableRow+"<img src='"+$(this).find("uri").text() + "'></a> ";
		});     
	    });
	tableRow=tableRow+"<br/><br/></div>"
	$("#div1").append(tableRow);
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
			setProvinceOptions(isoLanguage);
			setDynastyOptions(isoLanguage);
			var provinceSelection = $("#box1").val();
			var dynastySelection = $("#box3").val();
			setSiteOptions(provinceSelection,dynastySelection,isoLanguage);
	});

	// fires when there is a change in the province dropdown
	$("#box1").change(function(){
			// searching, so show the spinner icon
			$('#searchSpinner').show();
			var isoLanguage= $("#box0").val();
			var provinceSelection = $("#box1").val();
			var dynastySelection = $("#box3").val();
			setSiteOptions(provinceSelection,dynastySelection,isoLanguage);
	});

	// fires when there is a change in the dynasty dropdown
	$("#box3").change(function(){
			// searching, so show the spinner icon
			$('#searchSpinner').show();
			var isoLanguage= $("#box0").val();
			var provinceSelection = $("#box1").val();
			var dynastySelection = $("#box3").val();
			setSiteOptions(provinceSelection,dynastySelection,isoLanguage);
	});

	// Main routine: execute SPARQL queries to get values and add them to the select options
	setProvinceOptions(isoLanguage);
	setDynastyOptions(isoLanguage);
	var provinceSelection = $("#box1").val();
	var dynastySelection = $("#box3").val();
	setSiteOptions(provinceSelection,dynastySelection,isoLanguage);
//	setCategoryOptions();

	// creates a function that's executed when the button is clicked
	$("#searchButton").click(function(){
			// searching, so show the spinner icon
			$('#searchSpinner').show();
		
			//pulls data from the input boxes
			var isoLanguage= $("#box0").val();
			var provinceSelection = $('#box1').val();
			var siteSelection = $('#box2').val();
			var dynastySelection = $('#box3').val();
//			var category = $('#box4').val();
			// creates a string that contains the query with the data from the dropdowns
			// inserted into the right place.  The variable values are already enclosed in quotes as necessary.
			var query = "PREFIX time: <http://www.w3.org/2006/time#>" +
			        "SELECT DISTINCT ?siteName ?building ?buildingNameEn ?buildingNameZh ?buildingNameLatn ?lat ?long  WHERE {" +
				    "?site <http://www.geonames.org/ontology#featureCode> <http://www.geonames.org/ontology#S.ANS>." +
				    "?site <http://www.w3.org/2000/01/rdf-schema#label> ?siteName.FILTER (lang(?siteName)='zh-latn-pinyin')"

			if (siteSelection != '?site') 
				{
				if (isoLanguage=='en') {languageTag='en';}
				if (isoLanguage=='zh-hans') {languageTag='zh-hans';}
				query = query + "?site <http://www.w3.org/2000/01/rdf-schema#label> " + siteSelection + "@"+ languageTag + "."
				}
		
			if (dynastySelection != '?dynasty')
				{
				query = query + "?site <http://purl.org/dc/terms/temporal> ?interval." +
				    '?interval time:intervalStartedBy ?startDynasty.'+
				    '?interval time:intervalFinishedBy ?endDynasty.'+
				    // target dynasty must be earlier than ?endDynasty
				    '?endDynasty time:intervalMetBy* '+dynastySelection+'.'+
				    //target dynasty must be later than ?startDynasty
				    dynastySelection+' time:intervalMetBy* ?startDynasty.'
				}
				
			if (provinceSelection != '?province') 
				{
				if (isoLanguage=='en') {languageTag='zh-latn-pinyin';}
				if (isoLanguage=='zh-hans') {languageTag='zh-hans';}
				query = query + "?site <http://rs.tdwg.org/dwc/terms/stateProvince> " + provinceSelection + "@" + languageTag + "."
				}
		
			query = query + "?building <http://schema.org/containedInPlace> ?site." +
			    "OPTIONAL{?building <http://www.w3.org/2000/01/rdf-schema#label> ?buildingNameEn.FILTER ( lang(?buildingNameEn)='en')}" +
			    "OPTIONAL{?building <http://www.w3.org/2000/01/rdf-schema#label> ?buildingNameZh.FILTER ( lang(?buildingNameZh)='zh-hans')}" +
			    "OPTIONAL{?building <http://www.w3.org/2000/01/rdf-schema#label> ?buildingNameLatn.FILTER ( lang(?buildingNameLatn)='zh-latn-pinyin')}" +
			    "OPTIONAL{?building <http://www.w3.org/2003/01/geo/wgs84_pos#lat> ?lat.}" +
			    "OPTIONAL{?building <http://www.w3.org/2003/01/geo/wgs84_pos#long> ?long.}" +
			    "}" +
			    "ORDER BY ASC(?buildingName)" +
			    "LIMIT " + numResultstoReturn;
	
			// URL-encodes the query so that it can be appended as a query value
			var encoded = encodeURIComponent(query)
		
			// does the AJAX to send the HTTP GET to the Callimachus SPARQL endpoint
			// then puts the result in the "data" variable
			$.ajax({
			    type: 'GET',
			    url: 'https://sparql.vanderbilt.edu/sparql?query=' + encoded,
			    headers: {
				Accept: 'application/sparql-results+xml'
			    },
			    success: parseXml
			});
		    });
});

// converts nodes of an XML object to text. See http://tech.pro/tutorial/877/xml-parsing-with-jquery
// and http://stackoverflow.com/questions/4191386/jquery-how-to-find-an-element-based-on-a-data-attribute-value
function parseXml(xml) {
    // done searching, so hide the spinner icon
    $('#searchSpinner').hide();

    // tell the user how many results we found
    var numResults = $(xml).find("result").length;
    if (numResults < 1) {
        $("#div1").html("<h4 class=\"text-warning\">No buildings found</h4>");
    }
    else {
        $("#div1").html("<h4 class=\"text-success\">Found "+numResults+" buildings</h4>");

        //step through each "result" element
        $(xml).find("result").each(function() {

            tableRow="<div>";

            // pull the "binding" element that has the name attribute of "siteName"
            $(this).find("binding[name='siteName']").each(function() {
                tableRow=tableRow+"Site: <strong>"+$(this).find("literal").text() + "</strong>. Building: <strong>";
            });

            // pull the "binding" element that has the name attribute of "buildingNameZh"
            $(this).find("binding[name='buildingNameZh']").each(function() {
                tableRow=tableRow+$(this).find("literal").text() + " ";
            });

            // pull the "binding" element that has the name attribute of "buildingNameLatn"
            $(this).find("binding[name='buildingNameLatn']").each(function() {
                tableRow=tableRow+$(this).find("literal").text() + " ";
            });

            // pull the "binding" element that has the name attribute of "buildingNameEn"
            $(this).find("binding[name='buildingNameEn']").each(function() {
                tableRow=tableRow+"("+$(this).find("literal").text() + ") ";
            });
            
            latitude = "";

            // pull the "binding" element that has the name attribute of "lat"
            $(this).find("binding[name='lat']").each(function() {
               latitude=$(this).find("literal").text();
            });

            // pull the "binding" element that has the name attribute of "long"
            $(this).find("binding[name='long']").each(function() {
                longitude=$(this).find("literal").text();
            });
            tableRow = tableRow + '</strong><br/>'
            if (latitude!="") {
		    tableRow = tableRow + '<a target="top" href="http://maps.google.com/maps?output=classic&amp;q=loc:'+ latitude + ',';
		    tableRow = tableRow + longitude +'&amp;t=h&amp;z=16">Open location in map application</a><br/>';
		    tableRow = tableRow + '<img src="http://maps.googleapis.com/maps/api/staticmap?center='+latitude+','+longitude+'&amp;zoom=11&amp;size=300x300&amp;markers=color:green%7C'+latitude+','+longitude+'&amp;sensor=false"/>'
		    tableRow = tableRow + '<img src="http://maps.googleapis.com/maps/api/staticmap?center='+latitude+','+longitude+'&amp;maptype=hybrid&amp;zoom=18&amp;size=300x300&amp;markers=color:green%7C'+latitude+','+longitude+'&amp;sensor=false"/><br/>'
		   
		    }

		    // pull the "binding" element that has the name attribute of "building"
            $(this).find("binding[name='building']").each(function() {
                buildingURI=$(this).find("uri").text();
            });
            
            // the getBuildings function queries the endpoint for image tnumbnails and good quality accessURIs, then inserts the blob into the div
            getImages(buildingURI,tableRow);

        });


    }
}