NAME = ne_tagger

$(NAME): $(NAME).hs
	ghc -O -o $@ $^

.PHONY: clean test edit

clean:
	rm -f $(NAME) *.o *.hi *~ *#

test: $(NAME)
	./$(NAME) ner.counts

edit:
	emacs $(NAME).hs &

makedit:
	emacs Makefile &