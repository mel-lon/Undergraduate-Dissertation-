import convokit
from convokit import Corpus, download
corpus = Corpus(filename=download('subreddit-Cornell'))
corpus.print_summary_stats()