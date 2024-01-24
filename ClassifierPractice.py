import convokit
from convokit import Corpus, BoWTransformer, download
corpus = Corpus(filename=download('subreddit-Cornell'))
bow_transformer = BoWTransformer(obj_type="utterance")


# before transformation
print(corpus.get_utterance('dsbgljl').vectors)
print(corpus.vectors)
print(bow_transformer.fit_transform(corpus))

# after transformation
print(corpus.get_utterance('dsbgljl').vectors)

print(corpus.vectors)

print(corpus.get_vector_matrix('bow_vector'))