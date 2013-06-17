Installation instructions
==============

If you want to have all this for your own novel, follow these instructions

1. Clone or fork [this repo](http://github.com/JJ/hoborg).
2. The text of the novel is supposed to be in (text/text.md). Put your own text there.
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
That presupposses you've got perlbrew installed, if you don't, do sudo apt-get install perlbrew and then perlbrew init and the rest; perlbrew install perl 5.16.3 or whichever one you like the most. Follow instructions from [the perlbrew page](http://perbrew.pl), anyways. 
If you don't have, or don't want to have, perlbrew do basically the same with sudo in front of it

6. Now do
> cp apps/git-hooks.pl .git/hooks
> cd .git/hooks
> chmod +x git-hooks.pl
> ln -s git-hooks.pl post-commit
which will get you automatic sync with GitHub pages. 


7. Get a [http://travis-ci.org](Travis account) and activate the
service hook for your project. We are going to use this for
spell-check

8. Edit (text/words.dic) for the specific words in your novel that
should pass the spell check, but do not. Remember that the first line
contains the number of words.

9. There's a shortcut that processed the dictionary and does commit
and push for you, it's at text/commit.pl. You can use it cirectly or
do
> ln -s text/commit.pl c 
Remember always to chmod +x commit.pl

10. That's it. If you find trouble along the way, just let me know by raising  [an issue](https://github.com/JJ/hoborg/issues)