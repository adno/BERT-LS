OUTF=results/lsbert_potential.tsv
TMPF=results/lsbert_potential_tmp.tsv

printf "dataset\nPotential@1\nPotential@3\nPotential@5\nPotential@10\nPotential\n" \
	> $OUTF

for lang in en es pt
do
	for tt in ''  # DO NOT INCLUDE: '_trial'
	do
		LANG_TT_OUT="results/adno_tsar${tt}_${lang}.potential"
		LANG_TT_PUB="results/published_tsar${tt}_${lang}.potential"
		PRED="results/adno_tsar${tt}_${lang}.tsar"
		echo $PRED
		if [ -z "$tt" ]
		then
			tt='_test'
		fi
		python tsar_eval_pot.py \
			--gold_file datasets/tsar2022_${lang}${tt}_gold.tsv \
			--predictions_file $PRED \
			--output_file $PRED.eval > /dev/null
		
		echo "${lang} (reproduced)" > $LANG_TT_OUT

		echo $(sed -ne 's|^MAP@1/.* = \(.*\)|\1|p' $PRED.eval) >> $LANG_TT_OUT
		echo $(sed -ne 's|^Potential@3 = \(.*\)|\1|p' $PRED.eval)  >> $LANG_TT_OUT
		echo $(sed -ne 's|^Potential@5 = \(.*\)|\1|p' $PRED.eval)  >> $LANG_TT_OUT
		echo $(sed -ne 's|^Potential@10 = \(.*\)|\1|p' $PRED.eval)  >> $LANG_TT_OUT
		echo $(sed -ne 's|^Potential = \(.*\)|\1|p' $PRED.eval)  >> $LANG_TT_OUT

		paste $OUTF $LANG_TT_OUT $LANG_TT_PUB > $TMPF
		mv $TMPF $OUTF
	done
done

echo $OUTF