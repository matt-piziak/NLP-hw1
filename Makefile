NAME = ne_tagger

$(NAME): $(NAME).hs
	ghc -o $@ $^

.PHONY: clean test edit

clean:
	rm -f $(NAME) *.o *.hi *~

test:
	./$(NAME) ner.counts

edit:
	emacs $(NAME).hs &