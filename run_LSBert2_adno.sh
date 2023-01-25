FTES=fasttext/cc.es.300.bin
FTEN=fasttext/cc.en.300.bin
WFEN=SUBTLEX_frequency.xlsx
WFES=subtlex-es.tsv

DLEX=lex.mturk.txt
DNNS=NNSeval.txt
DBLS=BenchLS.txt

mkdir -p results

python LSBert2_adno.py \
  --no-ranking \
  --do_eval \
  --do_lower_case \
  --num_selections 10 \
  --prob_mask 0.0 \
  --eval_dir datasets/$DLEX \
  --bert_model bert-large-uncased-whole-word-masking \
  --max_seq_length 250 \
  --word_embeddings $FTEN \
  --word_frequency $WFEN \
  --ppdb ppdb-2.0-tldr \
  --output_SR_file results/adno_lex_mturk.txt > results/adno_lex_mturk.out
