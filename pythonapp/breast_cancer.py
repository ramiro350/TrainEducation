import os
from flask import Flask, request, jsonify
import pandas as pd
import sklearn
import pdb
from sklearn.model_selection import train_test_split
import tensorflow as tf
from tensorflow.keras.models import Sequential
from tensorflow.keras.layers import Dense

app = Flask(__name__)

@app.route('/train', methods=['POST'])
def train_model():
    pdb.set_trace()
    # Receive dataset file from request
    dataset_file = request.files['dataset']
    
    # Read dataset from file
    previsores = pd.read_csv(dataset_file)

    script_dir = os.path.dirname(__file__)
    file_path = os.path.join(script_dir, 'saidas_breast.csv')
    classe = pd.read_csv(file_path)

    previsores_treinamento, previsores_teste, classe_treinamento, classe_teste = train_test_split(previsores, classe, test_size=0.25)

    classificador = Sequential()
    classificador.add(Dense(units=16, activation='relu', kernel_initializer='random_uniform', input_dim=30))
    classificador.add(Dense(units=16, activation='relu', kernel_initializer='random_uniform'))
    classificador.add(Dense(units=1, activation='sigmoid'))

    otimizador = tf.keras.optimizers.Adam(learning_rate=0.001, decay=0.0001, clipvalue=0.5)
    classificador.compile(optimizer=otimizador, loss="binary_crossentropy", metrics=["binary_accuracy"])

    classificador.fit(previsores_treinamento, classe_treinamento, batch_size=10, epochs=100)

    previsoes = classificador.predict(previsores_teste)
    previsoes = (previsoes > 0.5)

    precisao = sklearn.metrics.accuracy_score(classe_teste, previsoes)
    matriz_confusao = sklearn.metrics.confusion_matrix(classe_teste, previsoes)

    return jsonify({'accuracy': precisao, 'confusion_matrix': matriz_confusao.tolist()})

if __name__ == '__main__':
    app.run(port=5000)
