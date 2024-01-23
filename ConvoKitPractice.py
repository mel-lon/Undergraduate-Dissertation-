import convokit
from convokit import Corpus, download, BoWTransformer
corpus = Corpus(filename=download('subreddit-Cornell'))
corpus.print_summary_stats()

#The bag of words transformer
random_utt = corpus.random_utterance()
print(random_utt)

# The utterance does not have any vectors associated with it
print(random_utt.vectors)


# The corpus does not have any vectors associated with it
print(corpus.vectors)

# Let's initialize a bag-of-words transformer to vectorize the texts of the utterances in the 
# corpus and to store these vectors in a vector matrix called 'bow'.
bow_transformer = BoWTransformer(obj_type="utterance", vector_name='bow')
bow_transformer.fit_transform(corpus)
print(random_utt)
print(random_utt.vectors)







