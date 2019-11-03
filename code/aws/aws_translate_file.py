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
