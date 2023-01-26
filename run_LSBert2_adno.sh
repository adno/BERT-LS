FTES=fasttext/cc.es.300.bin
FTEN=fasttext/cc.en.300.bin
WFEN=SUBTLEX_frequency.xlsx
WFES=subtlex-es.tsv

BERT_EN=bert-large-uncased-whole-word-masking
BERT_ES=dccuchile/bert-base-spanish-wwm-uncased

DLEX=lex.mturk.txt
DNNS=NNSeval.txt
DBLS=BenchLS.txt

DATA_TSAR_EN=tsar2022_en_test_gold.tsv
DATA_TSAR_ES=tsar2022_es_test_gold.tsv

mkdir -p results

# python LSBert2_adno.py \
#   --no-ranking \
#   --do_eval \
#   --do_lower_case \
#   --num_selections 20 \
#   --prob_mask 0.5 \
#   --eval_dir datasets/$DATA_TSAR_EN \
#   --bert_model $BERT_EN \
#   --max_seq_length 250 \
#   --word_embeddings $FTEN \
#   --word_frequency $WFEN \
#   --ppdb UNUSED \
#   -o results/adno_tsar_en.tsar \
#   --output_SR_file results/adno_tsar_en.result > results/adno_tsar_en.out

python LSBert2_adno.py \
  --no-ranking \
  --no-stemming \
  --do_eval \
  --do_lower_case \
  --num_selections 20 \
  --max_seq_length 350 \
  --prob_mask 0.5 \
  --eval_dir datasets/$DATA_TSAR_ES \
  --bert_model $BERT_ES --basic-tokenizer \
  --word_embeddings $FTES \
  --word_frequency $WFES \
  --ppdb UNUSED \
  -o results/adno_tsar_en.tsar \
  --output_SR_file results/adno_tsar_es.result > results/adno_tsar_es.out
