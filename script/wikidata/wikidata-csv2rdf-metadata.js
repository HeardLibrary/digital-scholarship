// Script to generate metadata JSON for mapping a CSV file to the Wikidata graph model according to the
// W3C Generating RDF from Tabular Data on the Web Recommendation https://www.w3.org/TR/csv2rdf/
// (c) 2020 Jessica K. Baskauf. 2020-08-23
// This program is released under The MIT License https://opensource.org/licenses/MIT
init()

function init() {
    $(document).ready(function() {
        // set on click listener for maximize/minimize section toggles
        $(".collapsible").click(function() {
            setUpCollapsibleOnClick($(this));
        });
        // add on-click listeners to buttons for adding section items
        //first section-item in a div of section-items must be a template
        $(".add-button").click(function() {
            setUpAddButtonOnClick($(this));
        })
        setUpLanguagesDropdown();
        // set up on-click handler for the Create CSV button
        $("#create-csv").click(function() {
            createCSV();
        })
        // set up on-click handler for the Create JSON button
        $("#create-json").click(function() {
            createJSON();
        })
        // set up clipboard copy buttons
        new ClipboardJS('.clipboard-button');
    });
}

function setUpCollapsibleOnClick(element) {
    // physically toggle the section contents visibility
    element.next().slideToggle();
    // swap + and - signs as necessary
    element.toggleClass(["maximized", "minimized"]);
}

function setUpDeleteButtonOnClick(element) {
    var parent = element.parent();
    var wasRefItem = parent.hasClass("ref-item");
    var siblings = parent.siblings();
    // delete item
    parent.remove();
    // if you deleted a reference (whose names depend on the reference's current index)
    // re-index each reference name
    if (wasRefItem) {
        siblings.each(function() {
            if (!$(this).hasClass("template")) {
                var propName = $(this).closest(".property-item-contents").find(".property-name").val();
                var refHashElement = $(this).find(".ref-hash");
                var refIndex = $(this).closest(".ref-items").children().index($(this));
                refHashElement.val(`${propName}_ref${refIndex}_hash`).trigger("change");
            }
        })
    }
}

function setUpAddButtonOnClick(addButtonElement) {
    // clone the template section item and remove the template tag, add it to the end of the list of section items
    $(addButtonElement).prev().append($(addButtonElement).prev().children().first().clone().removeClass("template"));
    var newItem = $(addButtonElement).prev().children().last();
    // add on-click listener for the delete button that will allow user to delete the newly added section item
    newItem.find(".delete-button").click(function() {
        setUpDeleteButtonOnClick($(this));
    });
    //if there are collapsible buttons, make them have the collapsible property
    var collapsibleElements = newItem.find(".collapsible");
    collapsibleElements.each(function() {
        //add an on-click function to each collapsible button
        $(this).click(function() {
            setUpCollapsibleOnClick($(this));
        })
    });
    //if there are add buttons, give them the adding property
    var addButtons = newItem.find(".add-button");
    addButtons.each(function() {
        $(this).click(function() {
            //recursively set up add buttons for nested elements - since there
            //are finite layers to the nesting (eg. adding reference properties
            // is the deepest it goes), this will end recursion when no add buttons
            // are in the set of addButtons
            setUpAddButtonOnClick($(this));
        })
    });
    // if the new item is a property, set up the uuid field to have _uuid in it by default
    if (newItem.hasClass("property-item")) {
        newItem.find(".statement-uuid").val("_uuid");
    }
    // if the new item is a reference, add a default value for the hash name based on the
    // current state of the property name and the index in the list of references
    var refIndex = null;
    if (newItem.hasClass("ref-item")) {
        refIndex = newItem.parent().children().index(newItem);
        var propName = newItem.closest(".property-item-contents").find(".property-name").val();
        newItem.find(".ref-hash").val(`${propName}_ref${refIndex}_hash`);
    }
    // if the new item is a qualifier, add a default prefix for the qualifier name based on the
    // current state of the property name
    if (newItem.hasClass("qual-item")) {
        var propName = newItem.closest(".property-item-contents").find(".property-name").val();
        newItem.find(".qualifier").val(`${propName}_`);
    }
    // if new item is a reference property, add a default prefix based on ref name
    if (newItem.hasClass("ref-property-item")) {
        var refHashName = newItem.closest(".ref-item-contents").find(".ref-hash").val();
        var refName = refHashName.replace("hash", "");
        newItem.find(".ref-prop").val(`${refName}`);
    }
    // if the new item contains a property-name input, set up its onchange handler
    // to change fields that depend on its value
    newItem.find(".property-name").change(function() {
        var currPropertyName = $(this).val();
        // update statement uuid value for this property
        newItem.find(".statement-uuid").val(currPropertyName + "_uuid");
        // update each reference hash value for this property's references
        newItem.find(".ref-item").each(function() {
            if (!$(this).hasClass("template")) {
                var refHashElement = $(this).find(".ref-hash");
                refIndex = $(this).closest(".ref-items").children().index($(this));
                refHashElement.val(`${currPropertyName}_ref${refIndex}_hash`).trigger("change");
            }
        })
        // update each qualifier name value for this property's qualifiers
        newItem.find(".qual-item").each(function() {
            if (!$(this).hasClass("template")) {
                var qualNameElement = $(this).find(".qualifier");
                qualNameElement.val(`${currPropertyName}_`);
            }
        })
    })
    // if the new item contains a reference hash input, set up its onchange handler
    // to change fields that depend on its value
    newItem.find(".ref-hash").change(function() {
        var currRefHash = $(this).val();
        var currRefName = currRefHash.replace("hash", "");
        // update each reference property name to reflect the change
        newItem.find(".ref-property-item").each(function() {
            if (!$(this).hasClass("template")) {
                var refPropNameElement = $(this).find(".ref-prop");
                refPropNameElement.val(`${currRefName}`);
            }
        })
    })
}

function hasDuplicate(list) {
    var map = new Map();
    var hasDuplicate = false;
    for (item of list) {
        if (map.has(item)) {
            hasDuplicate = true;
            break;
        } else {
            map.set(item, 1);
        }
    }
    return hasDuplicate;
}

function createCSV() {
    var somethingWrong = false;
    var string = "";
    var wikidataId = $("#wikidata-id").val();
    if ($.trim(wikidataId) == "") {
        alert("You must enter a Wikidata ID.");
        somethingWrong = true;
        return;
    }
    $(".property-items").children().each(function () {
        // find any unnamed property items that are not templates
        if ($(this).find(".property-name").val() == "" && !$(this).hasClass("template")) {
            alert("You have a property with no name specified.");
            somethingWrong = true;
            return;
        }
    })
    var propName = null;
    // for each input box, concatenate its contents onto the csv string
    $('input[type="text"]').each(function () {
        // if input actually contains something
        if ($(this).val() != "") {
            // save property names to append after property statement uuids
            //(order is flipped in JSON, needs to stay consistent in CSV too)
            if ($(this).hasClass("property-name")) {
                propName = $(this).val();
            }
            // if the input is not for property id, qualifier id, or reference property id
            // (which are referenced for the json but shouldn't have columns in the csv)
            else if (!($(this).hasClass("property-id") || $(this).hasClass("qualifier-id") || $(this).hasClass("ref-prop-id") || $(this).is("#csv-filename"))) {
                    string += $(this).val() + ",";
            }
            // append property names after statement UUIDs
            // this should always put the correct corresponding property name for the current
            // uuid since inputs are traversed in order, and prop-name always comes directly before statement-uuid
            if ($(this).hasClass("statement-uuid")) {
                string += propName + ",";
            }
        }
    });
    if (somethingWrong) {
        return;
    }
    string = string.substring(0, string.length - 1);
    // check that there are no duplicate column headers
    var columnList = string.split(",");
    if (hasDuplicate(columnList)) {
        alert("You have a duplicate column header.");
        return;
    }

    $("#output-csv-contents").text(string);
    //un-hide copy to clipboard button if it is hidden
    $("#csv-clip").removeAttr('hidden');
}

function createJSON() {
    var somethingWrong = false;
    var wikidataId = $("#wikidata-id").val();
    var csvFilename = $("#csv-filename").val();
    // make sure fields that are always required are filled
    if ($.trim(wikidataId) == "") {
        alert("You must enter a Wikidata ID.");
        somethingWrong = true;
        return;
    }
    if ($.trim(csvFilename) == "") {
        alert("You must enter a CSV filename.");
        somethingWrong = true;
        return;
    }
    $(".property-items").children().each(function () {
        // find any unnamed property items that are not templates
        if ($(this).find(".property-name").val() == "" && !$(this).hasClass("template")) {
            alert("You have a property with no name specified.");
            somethingWrong = true;
            return;
        }
    })
    // set up JSON header with the inputted csv filename
    var string =
    `{
        "@type": "TableGroup",
        "@context": "http://www.w3.org/ns/csvw",
        "tables": [
            {
                "url": "${csvFilename}.csv",
                "tableSchema": {
                    "columns": [ `;
    // also keep track of the column headers you've added to check for duplicates
    var columnList = [];
    // for each input box, create an entry in the JSON columns list and concatenate onto string
    $('input[type="text"]').each(function () {
        // based on the type of input, use the proper JSON formatting
        if ($(this).val() != "" && !$(this).is("#csv-filename")) {
            var result = "";
            // Wikidata ID or suppressed column
            if ($(this).is("#wikidata-id") || $(this).hasClass("suppressed-column")) {
                result = generateWikidataIDOrSuppressedEntry($(this));
            }
            //label or description
            else if ($(this).hasClass("label") || $(this).hasClass("description")) {
                result = generateLabelOrDescriptionEntry($(this), wikidataId);
            }
            // add basic property info (not including any references and qualifiers)
            // this includes two entries: one for the link between the entity with {wikidataID}
            // and the statementUUID, and one between the statementUUID and the property {propertyName}
            // *********(still need to get the order of these right)
            else if ($(this).hasClass("property-name")) {
                result = generatePropertyEntry($(this), wikidataId);
            }
            //qualifiers
            else if ($(this).hasClass("qualifier")) {
                result = generateQualifierEntry($(this), wikidataId);
            }
            //references
            else if ($(this).hasClass("ref-hash")) {
                result = generateReferenceHashEntry($(this), wikidataId);
            }
            //reference properties
            else if ($(this).hasClass("ref-prop")) {
                result = generateReferencePropertyEntry($(this));
            }
            columnList.push($(this).val());
            if (result == null) {
                somethingWrong = true;
                return;
            } else {
                string += result;
            }
        }
    });
    //remove trailing comma from last column list entry
    string = string.substring(0, string.length - 1);
    string +=`
                    ]
                }
            }
        ]
}`
    // check for duplicate column headers
    //if (hasDuplicate(columnList)) {
    //    alert("You have a duplicate column header.");
    //    return;
    //}
    if (somethingWrong) {
        return;
    }
    $("#output-json-contents").text(string);
    //un-hide copy to clipboard button if it is hidden
    $("#json-clip").removeAttr('hidden');
}

function generateWikidataIDOrSuppressedEntry(input) {
    return `
                        {
                            "titles": "${input.val()}",
                            "name": "${input.val()}",
                            "datatype": "string",
                            "suppressOutput": true
                        },`
}

function generateLabelOrDescriptionEntry(input, wikidataId) {
    //get the currently selected option in the language dropdown
    var languageDropdownSelectedId = input.siblings(".languages-dropdown").children("option:selected").attr("id");
    if (languageDropdownSelectedId == "language-choose") {
        alert(`You must choose a language for ${input.val()}.`);
        return null;
    } else {
        var string = `
                        {
                            "titles": "${input.val()}",
                            "name": "${input.val()}",
                            "datatype": "string",
                            "aboutUrl": "http://www.wikidata.org/entity/{${wikidataId}}",`
        if (input.hasClass("label")) {
            string += `
                            "propertyUrl": "rdfs:label",`
        }
        if (input.hasClass("description")) {
            string += `
                            "propertyUrl": "schema:description",`
        }
        string += `
                            "lang": "${languageDropdownSelectedId}"
                        },`
        return string;
    }
}

function generatePropertyEntry(input, wikidataId) {
    var string = "";
    var propertyName = input.val();
    var propertyId = input.siblings(".property-id").val();
    var statementUUID = input.siblings(".statement-uuid").val();
    var propertyTypeId = input.siblings(".type").children("option:selected").attr("id");
    // alert user if property ID has not been entered
    if ($.trim(propertyId) == "") {
        alert(`You must enter a property ID for ${propertyName}.`);
        return null;
    }
    // alert user if statement UUID has not been entered
    if ($.trim(statementUUID) == "") {
        alert(`You must enter a statement UUID for ${propertyName}.`);
        return null;
    }
    if (propertyTypeId == "type-choose") {
        alert(`You must choose a type for ${propertyName}.`);
        return null;
    }
    // add on column for the link between the entity and the statement UUID
    string += `
                        {
                            "titles": "${statementUUID}",
                            "name": "${statementUUID}",
                            "datatype": "string",
                            "aboutUrl": "http://www.wikidata.org/entity/{${wikidataId}}",
                            "propertyUrl": "http://www.wikidata.org/prop/${propertyId}",
                            "valueUrl": "http://www.wikidata.org/entity/statement/{${wikidataId}}-{${statementUUID}}"
                        },`
    // add on column for the link between statement UUID and property
    string += `
                        {
                            "titles": "${propertyName}",
                            "name": "${propertyName}",`
    // add datatype string unless propertyTypeId is type-date
    if (propertyTypeId == "type-date") {
        string += `
                            "datatype": "dateTime",`
    } else {
        string += `
                            "datatype": "string",`
    }
    string += `
                            "aboutUrl": "http://www.wikidata.org/entity/statement/{${wikidataId}}-{${statementUUID}}",
                            "propertyUrl": "http://www.wikidata.org/prop/statement/${propertyId}"`
    if (propertyTypeId == "type-item") {
        string += `,
                            "valueUrl": "http://www.wikidata.org/entity/{${propertyName}}"
                        },`
    } else if (propertyTypeId == "type-url") {
        string += `,
                            "valueUrl": "{+${propertyName}}"
                        },`
    } else {
        string += `
                        },`

    }
    return string;
}

function generateQualifierEntry(input, wikidataId) {
    var string = "";
    //get the currently selected option in the language dropdown
    var qualifierName = input.val();
    var qualifierId = input.siblings(".qualifier-id").val();
    var qualifierTypeId = input.siblings(".type").children("option:selected").attr("id");
    // traverse up the tree to find the closest occurance of a statement-uuid (should be within
    // the same property's contents)
    var statementUUID = input.closest(".property-item-contents").find(".statement-uuid").val();
    // alert user if qualifier ID has not been entered
    if ($.trim(qualifierId) == "") {
        alert(`You must enter a qualifier ID for ${qualifierName}.`);
        return null;
    }
    // alert user if statement UUID has not been entered
    if ($.trim(statementUUID) == "") {
        alert(`You must enter a statement UUID in order to generate JSON for ${qualifierName}.`);
        return null;
    }
    if (qualifierTypeId == "type-choose") {
        alert(`You must choose a type for ${qualifierName}.`);
        return null;
    }
    string += `
                        {
                            "titles": "${qualifierName}",
                            "name": "${qualifierName}",`
    // add datatype string unless qualifierTypeId is type-date
    if (qualifierTypeId == "type-date") {
        string += `
                            "datatype": "dateTime",`
    } else {
        string += `
                            "datatype": "string",`
    }
    string += `
                            "aboutUrl": "http://www.wikidata.org/entity/statement/{${wikidataId}}-{${statementUUID}}",
                            "propertyUrl": "http://www.wikidata.org/prop/qualifier/${qualifierId}"`
    if (qualifierTypeId == "type-item") {
        string += `,
                            "valueUrl": "http://www.wikidata.org/entity/{${qualifierName}}"
                        },`
    } else if (qualifierTypeId == "type-url") {
        string += `,
                            "valueUrl": "{+${qualifierName}}"
                        },`
    } else {
        string += `
                        },`
    }
    return string;
}

function generateReferenceHashEntry(input, wikidataId) {
    var referenceHash = input.val();
    var statementUUID = input.closest(".property-item-contents").find(".statement-uuid").val();

    return `
                        {
                            "titles": "${referenceHash}",
                            "name": "${referenceHash}",
                            "datatype": "string",
                            "aboutUrl": "http://www.wikidata.org/entity/statement/{${wikidataId}}-{${statementUUID}}",
                            "propertyUrl": "prov:wasDerivedFrom",
                            "valueUrl": "http://www.wikidata.org/reference/{${referenceHash}}"
                        },`
}

function generateReferencePropertyEntry(input) {
    var string = "";
    var refPropName = input.val();
    var refPropId = input.siblings(".ref-prop-id").val();
    var refPropTypeId = input.siblings(".type").children("option:selected").attr("id");
    var referenceHash = input.closest(".ref-item-contents").find(".ref-hash").val();
    // error checks
    if ($.trim(refPropId) == "") {
        alert(`You must enter a reference property ID for ${refPropName}.`);
        return null;
    }
    if ($.trim(referenceHash) == "") {
        alert(`You must enter a reference hash in order to generate JSON for ${refPropName}.`);
        return null;
    }
    if (refPropTypeId == "type-choose") {
        alert(`You must choose a type for ${refPropName}.`);
        return null;
    }
    string += `
                        {
                            "titles": "${refPropName}",
                            "name": "${refPropName}",`
    // add datatype string unless refPropTypeId is type-date
    if (refPropTypeId == "type-date") {
        string += `
                            "datatype": "dateTime",`
    } else {
        string += `
                            "datatype": "string",`
    }
    string += `
                            "aboutUrl": "http://www.wikidata.org/reference/{${referenceHash}}",
                            "propertyUrl": "http://www.wikidata.org/prop/reference/${refPropId}"`
    if (refPropTypeId == "type-item") {
        string += `,
                            "valueUrl": "http://www.wikidata.org/entity/{${refPropName}}"
                        },`
    } else if (refPropTypeId == "type-url") {
        string += `,
                            "valueUrl": "{+${refPropName}}"
                        },`
    } else {
        string += `
                        },`

    }
    return string;
}

// why is this not working?
function downloadCSV(text, name, type) {
    var a = $("#csv-download");
    var file = new Blob([text], {type: type});
    a.href = URL.createObjectURL(file);
    a.download = name;
    a.click();
}

function setUpLanguagesDropdown() {
    //temporary solution - move this list somewhere else
    var languages = ["aa,Afar","ab,Abkhaz","abe,Abenaki","abs,Ambonese","ace,Acehnese","acf,Saint Lucian Creole French","ady,Adyghe","ady-cyrl,Adyghe in Cyrillic script","aeb,Tunisian Arabic","aeb-arab,Tunisian Arabic in Arabic script","aeb-latn,Tunisian Arabic in Latin script","af,Afrikaans","agq,Aghem","ak,Akan","akl,Aklan","akz,Alabama","aln,Gheg Albanian","als,Swiss German","am,Amharic","ami,Amis","an,Aragonese","ang,Old English","anp,Angika","aoc,Pemon","ar,Arabic","arc,Aramaic","arn,Mapudungun","arq,Algerian Arabic","ary,Moroccan Arabic","as,Assamese","ase,American Sign Language","ast,Asturian","atj,Atikamekw","av,Avaric","avk,Kotava","awa,Awadhi","ay,Aymara","az,Azerbaijani","azb,South Azerbaijani","ba,Bashkir","ban,Balinese","bar,Bavarian","bat-smg,Samogitian","sgs,","bbc,Toba Batak language","bbc-latn,Batak Toba in Latin script","bcc,Southern Balochi","bcl,Central Bikol","be,Belarusian","be-tarask,Taraškievica","be-x-old,","bej,Beja","bfi,British Sign Language","bfq,Badaga","bg,Bulgarian","bgn,Western Balochi","bh,Bhojpuri","bho,","bi,Bislama","bjn,Banjar","bm,Bambara","bn,Bengali","bnn,Bunun","bo,Tibetan","bpy,Bishnupriya Manipuri","bqi,Bakhtiari","br,Breton","brh,Brahui","brx,Bodo language","bs,Bosnian","bsk,Burushaski","bss,Kose language","btm,Mandailing language","bto,Rinconada Bikol","bug,Buginese","bxr,Buryat","bxr,Russia Buriat","ca,Catalan","cbk-zam,Chavacano","cdo,Min Dong","ce,Chechen","ceb,Cebuano","ch,Chamorro","chn,Chinook Jargon","cho,Choctaw","chr,Cherokee","chu,Church Slavonic","chy,Cheyenne","ckb,Sorani","ckt,Chukchi","cnr,Montenegrin","co,Corsican","cop,Coptic","cps,Capiznon","cr,Cree","crh,Crimean Tatar","crh-cyrl,Crimean Tatar Cyrillic alphabet","crh-latn,Crimean Tatar Latin alphabet","crs,Seychellois Creole","cs,Czech","csb,Kashubian","cu,Old Church Slavonic","cv,Chuvash","cy,Welsh","da,Danish","de,German","de-at,Austrian German","de-ch,Swiss Standard German","de-formal,formal address in German","din,Dinka","diq,Zazaki","dsb,Lower Sorbian","dtp,Kadazandusun","dtp,Central Dusun language","dty,Doteli","dv,Dhivehi","dz,Dzongkha","ee,Ewe","eg,Egyptian Arabic","egl,Emilian","el,Modern Greek","el,Greek","eml,Emilian-Romagnol","en,English","en-ca,Canadian English","en-gb,British English","en-in,Indian English","en-us,American English","eo,Esperanto","es,Spanish","es-419,Latin American Spanish","es-formal,formal Spanish","es-mx,Mexican Spanish","esu,Central Alaskan Yup'ik","et,Estonian","ett,Etruscan","eu,Basque","ext,Extremaduran","eya,Eyak","fa,Persian","fa-af,Dari","ff,Fula","fi,Finnish","fit,Meänkieli","fiu-vro,Võro","vro,","fj,Fijian","fkv,kven","fo,Faroese","fon,Fon","fos,Siraya","fr,French","fr-be,Belgian French","fr-ca,Canadian French","frc,Louisiana French","frm,Middle French","fro,Old French","frp,Franco-Provençal","frr,North Frisian","fuf,Pular","fur,Friulian","fy,West Frisian","ga,Irish","gaa,Ga","gag,Gagauz","gan,Gan","gan-hans,simplified Gan","gan-hant,traditional Gan","gcr,Guianan Creole","gd,Scottish Gaelic","gez,Ge'ez","gkm,Medieval Greek","gl,Galician","glk,Gilaki","gml,Middle Low German","gn,Guarani","gom,Goan Konkani","gom-deva,Goan Konkani in Devanagari script","gom-latn,Goan Konkani in Latin script","gor,Gorontalo","got,Gothic","grc,Ancient Greek","gsw,Alemannic","gu,Gujarati","gv,Manx","ha,Hausa","hai,Haida","hak,Hakka","haw,Hawaiian","he,Hebrew","hi,Hindi","hif,Fiji Hindi","hif-latn,Fiji Hindi in Latin script","hil,Hiligaynon","ho,Hiri Motu","hr,Croatian","hrx,Hunsrik","hsb,Upper Sorbian","ht,Haitian Creole","hu,Hungarian","hu-formal,formal Hungarian","hy,Armenian","hyw,Western Armenian","hz,Herero","ia,Interlingua","id,Indonesian","ie,Interlingue","ig,Igbo","ii,Nuosu","ik,Inupiat","ike-cans,Eastern Canadian in aboriginal syllabics","ike-latn,Eastern Canadian in Latin script","ilo,Ilocano","ine,Proto-Indo-European","inh,Ingush","ins,Indian Sign Language","io,Ido","is,Icelandic","it,Italian","iu,Inuktitut","ja,Japanese","jam,Jamaican Patois","jbo,Lojban","jut,Jutlandic","jv,Javanese","ka,Georgian","kaa,Karakalpak","kab,Kabyle","kbd,Kabardian","kbd-cyrl,Kabardian in Cyrillic script","kbp,Kabiye","kea,Cape Verdean Creole","kg,Kongo","kha,Khasi","khw,Khowar","ki,Gikuyu","kiu,Kirmanjki","kj,Kwanyama","kjh,Khakas","kjp,Eastern Pwo","kk,Kazakh","kk-arab,Kazakh Arabic alphabets","kk-cn,Kazakh in China","kk-cyrl,Kazakh in Cyrillic script","kk-kz,Kazakh in Kazakhstan","kk-latn,Kazakh in Latin script","kk-tr,Kazakh in Turkey","kl,Greenlandic","km,Khmer","kn,Kannada","ko,Korean","ko-kp,North Korean standard language","ko-kr,South Korean standard language","koi,Permyak language","koy,Koyukon","kr,Kanuri","krc,Karachay-Balkar","kri,Krio","krj,Kinaray-a language","krl,Karelian","krx,Karon","ks,Kashmiri","ks-arab,Kashmiri in Arabic script","ks-deva,Kashmiri in Devanagari script","ksh,Kölsch","ksh,Ripuarian","ku,Kurmanji","ku,Kurdish languages","ku-arab,Kurdish Arabic alphabet","ku-latn,Kurdish in Latin script","kum,Kumyk","kv,Komi","kw,Cornish","ky,Kyrgyz","ky-arab,Kyrgyz in Arabic script","ky-cyrl,Kyrgyz in Cyrillic script","la,Latin","lad,Ladino","lag,Rangi language","lat-vul,Vulgar Latin","lb,Luxembourgish","lbe,Lak","lez,Lezgian","lfn,Lingua Franca Nova","lg,Luganda","li,Limburgish","lij,Ligurian","liv,Livonian","lki,Laki","lkt,Lakota","lld,Ladin","lmo,Lombard","ln,Lingala","lo,Lao","loz,Lozi","lrc,Northern Luri","lt,Lithuanian","ltg,Latgalian","lus,Mizo language","luz,Southern Luri","lv,Latvian","lzz,Laz","mai,Maithili","map-bms,Banyumasan","mdf,Moksha","mfe,Mauritian Creole","mg,Malagasy","mh,Marshallese","mhr,Meadow Mari","mi,Maori","min,Minangkabau","mis,Riksmål","mis,Early Middle Japanese","mis,unknown","mk,Macedonian","ml,Malayalam","mn,Mongolian","mnc,Manchu","mni,Meitei","mnw,Mon","mo,Moldovan","moe,Innu-aimun","mr,Marathi","mrj,Hill Mari","ms,Malay","mt,Maltese","mui,Musi","mul,multiple languages","mus,Muscogee","mwl,Mirandese","mwv,Mentawai","my,Burmese","myv,Erzya","mzn,Mazanderani","na,Nauruan","nah,Nahuatl","nap,Neapolitan","nb,Bokmål","nds,Low German","nds-nl,Dutch Low Saxon","ne,Nepali","new,Newar","ng,Ndonga","niu,Niuean","nl,Dutch","nl-be,Belgian Dutch","nl-informal,informal Dutch","nn,Nynorsk","nn-hognorsk,Høgnorsk","no,Norwegian","nod,Northern Thai","nog,Nogai","non,Old Norse","nov,Novial","nqo,N'Ko","nr,Southern Ndebele","nrm,Norman","fr-x-nrm,","nso,Northern Sotho","nui,Kombe language","nv,Navajo","nxm,Numidian","ny,Chewa","nys,Noongar","oc,Occitan","olo,Livvi-Karelian","om,Oromo","ood,O'odham","or,Odia","os,Ossetian","ota,Ottoman Turkish","otk,Old Turkic","pa,Punjabi","pa,Eastern Punjabi","pag,Pangasinan","pam,Kapampangan","pap,Papiamento","pcd,Picard","pdc,Pennsylvania German","pdt,Plautdietsch","peo,Old Persian","pfl,Palatinate German","pi,Pali","pih,Pitkern","pis,Pijin","pjt,Pitjantjatjara","pko,Pökoot","pl,Polish","pms,Piedmontese","pmy,Papuan Malay","pnb,Western Punjabi","pnt,Pontic Greek","ppu,Papora-Hoanya language","prg,Old Prussian","ps,Pashto","pt,Portuguese","pt-br,Brazilian Portuguese","pyu,Puyuma","qu,Quechua","quc,K’iche’","qug,Kichwa","rcf,Réunion Creole","rgn,Romagnol","rif,Riffian","rm,Romansh","rm-puter,Putèr","rm-rumgr,Rumantsch Grischun","rm-surmiran,Surmiran","rm-sursilv,Sursilvan","rm-sutsilv,Sutsilvan","rm-vallader,Vallader","rmy,Romani","rn,Kirundi","ro,Romanian","roa-tara,Tarantino","it-x-tara,","ru,Russian","ru-sib,Siberian language","rue,Rusyn","rup,Aromanian","ruq,Megleno-Romanian","ruq-cyrl,Megleno-Romanian in Cyrillic script","ruq-latn,Megleno-Romanian in Latin script","rw,Kinyarwanda","rwr,Marwari (India)","ryu,Okinawan","sa,Sanskrit","sah,Sakha","sat,Santali","sc,Sardinian","scn,Sicilian","sco,Scots","sd,Sindhi","sdc,Sassarese","sdh,Southern Kurdish","se,Northern Sami","sei,Seri","ses,Koyraboro Senni","sg,Sango","sh,Serbo-Croatian","shi,Shilha","shi-latn,Tachelhit in Latin script","shi-tfng,Tachelhit in Tifinagh script","shn,Shan","shy,Shawiya","shy-latn,Shawiya in Latin script","si,Sinhala","sid,Sidamo","simple,Simple English","en-x-simple,","en-simple,","sjd,Kildin Sami","sje,Pite Sami","sjm,Mapun","sju,Ume Sami","sk,Slovak","skr,Saraiki language","skr-arab,Saraiki in Arabic script","sl,Slovene","sli,Silesian German","sm,Samoan","sma,Southern Sami","smj,Lule Sami","smn,Inari Sami","sms,Skolt Sami","sn,Shona","so,Somali","sou,Southern Thai","sq,Albanian","sr,Serbian","sr-ec,Serbian Cyrillic alphabet","sr-ec,Serbian written in Cyrillic","sr-el,Serbian Latin alphabet","srn,Sranan tongo","srq,Sirionó","ss,Swazi","ssf,Thao","st,Sesotho","stq,Saterland Frisian","sty,Siberian Tatar","su,Sundanese","sv,Swedish","sw,Swahili","szl,Silesian","szy,Sakizaya","ta,Tamil","tay,Atayal","tcy,Tulu","te,Telugu","tet,Tetum","tg,Tajik","tg-arab,Tajik in Arabic script","tg-cyrl,Tajik in Cyrillic script","tg-latn,Tajik in Latin script","th,Thai","ti,Tigrinya","tk,Turkmen","tl,Tagalog","tlh,Klingon","tly,Talysh","tn,Tswana","to,Tongan","tpi,Tok Pisin","tr,Turkish","tru,Turoyo","trv,Seediq","ts,Tsonga","tsg,Tausug","tt,Tatar","tt-cyrl,Tatar in Cyrillic script","tt-latn,Tatar in Latin script","tum,Tumbuka","tvl,Tuvaluan","tw,Twi","ty,Tahitian","tyv,Tuvan","tzl,Talossan","tzm,Central Atlas Tamazight","udm,Udmurt","ug,Uyghur","ug-arab,Uyghur Arabic alphabet","ug-latn,Uyghur Latin alphabet","uk,Ukrainian","umu,Munsee","und,undetermined language","ur,Urdu","uun,Pazeh language","uz,Uzbek","uz-cyrl,Uzbek Cyrillic alphabet","uz-latn,Uzbek Latin alphabet","uzs,Southern Uzbek","ve,Venda","vec,Venetian","vep,Veps","vi,Vietnamese","vls,Flemish","vls,West Flemish","vmf,Main-Franconian","vo,Volapük","vot,Votic","wa,Walloon","wal,Wolaytta","war,Waray","wbl,Wakhi","wo,Wolof","wuu,Wu Chinese","wym,Vilamovian","xal,Kalmyk Oirat","xh,Xhosa","xmf,Mingrelian","xpu,Punic","xsy,Saisiyat","yai,Yaghnobi","yap,Yapese","yav,Yangben","ydg,Yidgha","yi,Yiddish","yo,Yoruba","yrk,Nenets","yrl,Nheengatu","za,Zhuang","zea,Zeelandic","zgh,Standard Moroccan Berber","zh,Chinese","zh-classical,Classical Chinese","zh-cn,Putonghua","zh-hans,Simplified Chinese","zh-hant,Traditional Chinese","zh-min-nan,Southern Min","zh-mo,Chinese in Macau","zh-my,Malaysian Mandarin","zh-sg,Singaporean Mandarin","zh-tw,Taiwanese Mandarin","zh-tw,National language of Republic of China","zh-yue,Yue Chinese","zh-yue,Cantonese","zu,Zulu","zun,Zuni"];
    for (i = 0; i < languages.length; i++) {
        var langRes = languages[i].split(",");
        var newOpt = $("<option/>").text(langRes[0] + " (" + langRes[1] + ")");
        newOpt.attr('id', langRes[0]);
        $(".languages-dropdown").append(newOpt);
    }
}
