---
permalink: /host/aws/translate/
title: Using an AWS service - Amazon Translate
breadcrumb: Translate
---

# Using an AWS Service - Amzaon Translate as an Example

AWS has many cool services that you can explore.  You can see them by logging in to your account, then clicking on the Services menu at the top of the page.

Before you can use a service, you first need to understand how it works.  Typically, there will be a way to explore the service through the web interface, but also a way to access it more efficiently using the Command Line Interface (CLI).  Services can also be accessed programatically using a Software Development Kit (SDK) for one of the languages supported by AWS such as Java or Python.

## Trying Amazon Translate using the web interface

Click on Services, then type `Translate` in the search box.  Click on the `Amazon Translate` search result.

In the resulting metrics page, click on `Amazon Translate` in the upper left to get to the welcome page.  Click on the `Launch real-time translation` button in the upper right to get to the test screen.

I'm going to test the service by tranlating a paragraph from my blog.  Paste the text to be translated into the left box.  If the language isn't correctly autodetected, select the language from the `Source language` dropdown.  

Select the target language using the `Target language` dropdown.  The text will automatically be translated into the target language.  Change the dropdown to see the text translated into other languages.

## Using the CLI to invoke Amazon Translate

We can carry out the same action directly using the command line (assuming that the IAM user whose keys are being used for access has permissions to use Translate). 

In the console (Terminal on Mac or Command Prompt on Windows), enter the following:

```
aws translate translate-text --source-language-code "en" --target-language-code "es" --text "This is the sixth and final post in a series on the TDWG Standards Documentation Specification (SDS).  The five earlier posts explain the history and model of the SDS, and how to retrieve the machine-readable metadata about TDWG standards."
```

**Note:** We can skip providing a value for `--region` if we want to use the default region that we specified when we configured the CLI.

Here's what happens:

![CLI translation](../images/translate-cli.png)

Notice that the output was returned as JSON.   

For a small amount of text like this, it might be practical to copy and paste from the console window.  But it would probably be easier to input and output from a file. Copy the following text and paste it into a code or text editor:

```
{
    "Text": "This is the sixth and final post in a series on the TDWG Standards Documentation Specification (SDS).  The five earlier posts explain the history and model of the SDS, and how to retrieve the machine-readable metadata about TDWG standards.", 
    "SourceLanguageCode": "en", 
    "TargetLanguageCode": "es"
}
```

Save the file as `translate.json` in the directory from which you are running the CLI.  Now enter this command:

```
aws translate translate-text --cli-input-json file://translate.json > translated.json
```

Instead of putting the output on the console screen, the output will be redirected into the file `translated.json` in the working directory.  You can then open the `translated.json` file with a text editor and extract the translated text.  This is probably more practical when the amount of text to be translated is large.  

**Note:** Because translations are likely to produce characters in non-Latin character sets or use characters with diacritics, it's important that the application used to open the translated file treates it as UTF-8 encoded characters.  Otherwise, you'll see weird boxes or diamonds where the non-Latin characters should be.

For more details, see the [Getting Started](https://docs.aws.amazon.com/translate/latest/dg/get-started-cli.html) page.  

## Using a Python script to invoke Amazon Translate

Saving the text to be translated and retrieving the translated text from JSON formatted files doesn't make a lot of sense when the text is being handled manually. So that's a bit of a pain when your method for running the Translate service is the CLI.

If you are only translating one document, you might as well just paste the text into Google Translate.  However, if you have many documents to translate, then you will probably want to script the process.  In that case, JSON is the generally the easiest way to input and manipulate text.  In this example, we will use a Python script to:
- input text from a file
- turn the text into JSON
- pass the JSON to Amazon Translate
- get JSON back from Translate
- remove the translated text from the JSON and save it as a file

The Python module containing the SDK for AWS is called "boto" ([named after a freshwater dolphin that swims in the Amazon river](https://github.com/boto/boto3/issues/1023#issuecomment-287127647)).  The current version is 3, so the module that is imported is `boto3`.  The first time you try to import boto3, you could get a "No module named 'boto3'" error.  In that case, you will need to install boto3 by issuing the command

```
pip install boto3
```

However, if you've already installed the CLI, boto3 should already be installed.  Boto also uses the same credential and configuration files as the CLI, so you should be ready to go with that.  

Generally, one creates an instance of the service being used, then calls methods that are appropriate for that service, like this:

```
translate = boto3.client(service_name='translate', region_name='us-east-2', use_ssl=True)
```

For Amazon Translate, the primary method is `.translate_text()`.  This example sends a hard-coded text string to be translated, then shows both the response JSON and the `TranslatedText` value extracted from the JSON:

```
import boto3

# Settings
sourceLanguage = 'en'
targetLanguage = 'es'
textString = 'This is the sixth and final post in a series on the TDWG Standards Documentation Specification (SDS).  The five earlier posts explain the history and model of the SDS, and how to retrieve the machine-readable metadata about TDWG standards.'

# carry out the translation
translate = boto3.client(service_name='translate', use_ssl=True)
result = translate.translate_text(Text=textString, SourceLanguageCode=sourceLanguage, TargetLanguageCode=targetLanguage)
print(result)
print()
print(result.get('TranslatedText'))
```

To run the script, go to [this page](), then right click on the `Raw` button and select `Save link as...`.  Save the file to the active directory for your console.  Then in the console, enter

```
python aws_translate_screen.py
```

The following version of the script reads the text to be translated from a file and outputs the translated text to another file.

```
import boto3

# Settings
sourceLanguage = 'en'
targetLanguage = 'zh'
inputFileName = 'translate.txt'
outputFileName = 'translated.txt'

# input the text to be translated from a file
with open(inputFileName, 'rt', encoding='utf-8') as fileObject:
    textString = fileObject.read()

# carry out the translation
translate = boto3.client(service_name='translate', use_ssl=True)
result = translate.translate_text(Text=textString, SourceLanguageCode=sourceLanguage, TargetLanguageCode=targetLanguage)
outputText = result.get('TranslatedText')

# output the translated text to a file
with open(outputFileName, 'wt', encoding='utf-8') as fileObject:
    fileObject.write(outputText)
    
print('Translation completed.')
```

To run the script, go to [this page]() and download as you did the last script.  The sample text is in [this file](), which you can download to the same directory as the script, or you can use a text editor to create and save in the working directory a file called `translate.txt`.  

----
Revised 2019-11-03
