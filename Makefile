NAME = ne_tagger

$(NAME): $(NAME).hs
	ghc -o $@ $^

.PHONY: clean test

clean:
	rm -f $(NAME) *.o *.hi *~

test:
	./$(NAME) ner.counts