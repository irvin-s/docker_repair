# This script using tfidf to generate keywords from Dockerfiles log fragment.
import math
import nltk

#Remove stopwords
##Creating a list of custom stopwords and adding to stop words
stop_words = ["91m+", "91mexec\x1b", "91m", "go\x1b", "91m", "get\x1b", "91m", "-v\x1b", "91m", "-d\x1b", "91m", "91mca", "91merror", "0m\x1b", "91mnpm", "91mE","\x1b","step", "bin", "sh", "returned", "non", "zero", "code", "manifest", "unknown", "pull", "access", "denied", "invalid", "reference", "format", "failed", "process", "command", "me", "mthe", "for", "from", "0mthe", "91me","non-zero", "$", "*", "(", ")", "&", "¨", "%",":", "?", "/", "[", "]", "{", "}", "´", "'", ",", ".", "!", "@", "#", "-", "|", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]

#Removing stop words and tokenizing the text
def remostopwords(s):
    
    s = nltk.word_tokenize(s)
    for i in range (len(s)):
        s[i] = s[i].lower()   
    s = [w for w in s if not w in stop_words] 
    
    return s

#Tokenize, remove stopwords, duplicates and calculate the tf_idf 
def keyGen(documents):
    
    documents = remostopwords(documents)

    #---Calculate term frequency --

    #First: tokenize words
    dictOfWords = {}

    for index, sentence in enumerate(documents):
        tokenizedWords = sentence.split(' ')
        dictOfWords[index] = [(word,tokenizedWords.count(word)) for word in tokenizedWords]

    #print(dictOfWords)

    #second: remove duplicates
    termFrequency = {}

    for i in range(0, len(documents)):
        listOfNoDuplicates = []
        for wordFreq in dictOfWords[i]:
            if wordFreq not in listOfNoDuplicates:
                listOfNoDuplicates.append(wordFreq)
            termFrequency[i] = listOfNoDuplicates
    #print(termFrequency)

    #Third: normalized term frequency
    normalizedTermFrequency = {}
    for i in range(0, len(documents)):
        sentence = dictOfWords[i]
        lenOfSentence = len(sentence)
        listOfNormalized = []
        for wordFreq in termFrequency[i]:
            normalizedFreq = wordFreq[1]/lenOfSentence
            listOfNormalized.append((wordFreq[0],normalizedFreq))
        normalizedTermFrequency[i] = listOfNormalized

    #print(normalizedTermFrequency)


    #---Calculate IDF

    #First: put al sentences together and tokenze words

    allDocuments = ''
    for sentence in documents:
        allDocuments += sentence + ' '
    allDocumentsTokenized = allDocuments.split(' ')

    #print(allDocumentsTokenized)

    allDocumentsNoDuplicates = []

    for word in allDocumentsTokenized:
        if word not in allDocumentsNoDuplicates:
            allDocumentsNoDuplicates.append(word)


    #print(allDocumentsNoDuplicates)

    #Second calculate the number of documents where the term t appears

    dictOfNumberOfDocumentsWithTermInside = {}

    for index, voc in enumerate(allDocumentsNoDuplicates):
        count = 0
        for sentence in documents:
            if voc in sentence:
                count += 1
        dictOfNumberOfDocumentsWithTermInside[index] = (voc, count)

    #print(dictOfNumberOfDocumentsWithTermInside)


    #calculate IDF

    dictOFIDFNoDuplicates = {}


    for i in range(0, len(normalizedTermFrequency)):
        listOfIDFCalcs = []
        for word in normalizedTermFrequency[i]:
            for x in range(0, len(dictOfNumberOfDocumentsWithTermInside)):
                if word[0] == dictOfNumberOfDocumentsWithTermInside[x][0]:
                    listOfIDFCalcs.append((word[0],math.log(len(documents)/dictOfNumberOfDocumentsWithTermInside[x][1])))
        dictOFIDFNoDuplicates[i] = listOfIDFCalcs

    #print(dictOFIDFNoDuplicates)

    #Multiply tf by idf for tf-idf

    dictOFTF_IDF = {}
    for i in range(0,len(normalizedTermFrequency)):
        listOFTF_IDF = []
        TFsentence = normalizedTermFrequency[i]
        IDFsentence = dictOFIDFNoDuplicates[i]
        for x in range(0, len(TFsentence)):
            listOFTF_IDF.append((TFsentence[x][0]))
            #,TFsentence[x][1]*IDFsentence[x][1]
        dictOFTF_IDF[i] = listOFTF_IDF
             
    return dictOFTF_IDF
