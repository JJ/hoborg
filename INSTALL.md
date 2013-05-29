---
layout: index
---

Installation instructions
==============

If you want to have all this for your own novel, follow these instructions

1. Clone or fork [this repo](http://github.com/JJ/hoborg).
2. The text of the novel is supposed to be in (text/text). Put your own text there.
3. Create a Twitter account and activate it in Settings -> Service
hooks to send all commits there
4. Go to Options and use the Automatic Page generator to activate your
pages. Follow [instructions
here](http://stackoverflow.com/questions/15214762/how-can-i-sync-documentation-with-github-pages)
to change layout so that it can be synced with the next instruction.
5. Now comes the hard part (yes, harder than above), so stay with me here. Install Perl (I said
the hard part was starting)  and do 
> cpan Git::Hooks
> cpan File::Slurp
Then 
> cp apps/git-hooks.pl .git/hooks
> cd .git/hooks
> chmod +x git-hooks.pl
> ln -s git-hooks.pl post-commit
which will get you automatic sync with GitHub pages
6. Get a [http://travis-ci.org](Travis account) and activate the
service hook for your project. We are going to use this for
spell-check
7. Edit (text/words.dic) for the specific words in your novel that
should pass the spell check, but do not. Remember that the first line
contains the number of words.
8 That's it. If you find trouble along the way, just let me know. 