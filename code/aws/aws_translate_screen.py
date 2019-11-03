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