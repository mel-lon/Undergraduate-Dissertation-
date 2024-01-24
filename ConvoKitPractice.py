import convokit
from convokit import Corpus, download, BoWTransformer
corpus = Corpus(filename=download('subreddit-Cornell'))
corpus.print_summary_stats()


#The bag of words transformer
print('Section 1 - The bag of words transformer')


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
print(corpus.vectors)
print(random_utt.vectors)

## vectorises the text across all utterances in corpus and adds it to a matrices called bow







##################### fetching the vector for the utterance ###########################
print('Section 2 - Fetching the vector for the utterance')

random_utt.get_vector('bow')

# We can get a more interpretable display of the vector as a dataframe
print(random_utt.get_vector('bow', as_dataframe=True))

# Notice that the dataframe has a row index corresponding to the utterance ID, 
# and a column index corresponding to the n-grams in the bag-of-words vectorization.
# This is handled automatically by the BoWTransformer.


## to get subsets
print(random_utt.get_vector('bow', as_dataframe=True, columns=['youtu', 'youtube', 'yr']))

# This works for the non-dataframe format too
print(random_utt.get_vector('bow', as_dataframe=False, columns=['youtu', 'youtube', 'yr']))










##https://github.com/CornellNLP/ConvoKit/blob/master/examples/vectors/vector_demo.ipynb