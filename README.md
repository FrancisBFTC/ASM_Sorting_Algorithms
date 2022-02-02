# Algoritmos de Ordenação em Linguagem Assembly

Este Repositório é dedicado aos algoritmos de ordenação em Linguagem Assembly. Para executar, basta transformá-lo o arquivo "Program.bin" em uma imagem de disco, neste caso recomendado para "Arquivo de Diskette" que pode ser obtido pela ferramenta "DD".

1ª Programe um bootloader em Assembly, que carregue o código a ser executado num endereço de memória e salte para este endereço.
2ª Mescle o bootloader e o arquivo Program.bin numa só Imagem de disco, Exemplo: ImageDisk.img.
3ª Transfira o arquivo "ImageDisk.img" para o pendrive via ferramenta "DD" no Linux ou via "Rufus Portable" (Software) no Windows.
4ª Execute na máquina virtual Oracle VirtualBox diretamente pelo Pendrive.

Obs.: Se quiser executar o ImageDisk.img diretamente na máquina virtual sem utilizar o Pendrive, ignore a 3ª e 4ª etapa e instale a máquina virtual QEMU!
Execute o ImageDisk.img diretamente no QEMU.

Existem vários tutoriais e sites ensinando a utilizar e baixar tanto o DD como também o Rufus Portable mas existe uma forma melhor de fazer isto: Estes arquivos dos algoritmos podem ser incluídos em um sistema operativo já pronto feito por você mesmo, sem mesmo precisar montar o Program.asm para Program.bin. Mas pra isto é necessário assistir o meu curso de Desenvolvimento de Sistemas Operacionais em Assembly, disponível no link abaixo:

[Desenvolva Seu Próprio SISTEMA OPERACIONAL e Testes os algoritmos acima em nível de hardware!!!](https://www.youtube.com/playlist?list=PLsoiO2Be-2z8BfsSkspJfDiuKeC9-LSca)
