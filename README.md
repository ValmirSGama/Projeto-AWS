###  Projeto AWS-Cloud Pratictioner | Programa de Bolsas-DevSecOps

## Descrição:
## Requisitos AWS:
- Gerar uma chave pública para acesso ao ambiente;
- Criar 1 instância EC2 com o sistema operacional Amazon Linux 2 (Família t3.small, 16 GB SSD);
- Gerar 1 elastic IP e anexar à instância EC2;
- Liberar as portas de comunicação para acesso público: (22/TCP, 111/TCP e UDP, 2049/TCP/UDP, 80/TCP, 443/TCP).
  
## Requisitos no linux:
- Configurar o NFS entregue;
- Criar um diretorio dentro do filesystem do NFS com seu nome;
- Subir um apache no servidor - o apache deve estar online e rodando;
- Criar um script que valide se o serviço esta online e envie o resultado da validação para o seu diretorio no nfs;
- O script deve conter - Data HORA + nome do serviço + Status + mensagem personalizada de ONLINE ou offline;
- O script deve gerar 2 arquivos de saida: 1 para o serviço online e 1 para o serviço OFFLINE;
- Preparar a execução automatizada do script a cada 5 minutos.
- Fazer o versionamento da atividade;
- Fazer a documentação explicando o processo de instalação do Linux.
  
### AWS: Construindo uma topologia para uma EC2 Linux.
- Vamos iniciar criando uma chave pública para acesso ao ambiente.
- Busque por EC2, no campo de pesquisa do console AWS.
- Estando na EC2, role a lateral esquerda até a parte de “Network & Security”, click em “Key Pairs”.
- Create Key pair.
- Dê um nome de sua escolha à chave.
- Selecionei o formato .ppk, pois a utilizei no Putty.

 ![Captura de Tela (672)](https://github.com/ValmirSGama/Projeto-AWS/assets/111182775/85446738-e5b2-43b9-88ec-6d413dc0253c)

- Para comportar nossa instância EC2 Linux, antes precisamos criar uma topologia VPC para ela.
- Busque por VPC, no campo de pesquisa do console AWS.
- Ligeiramente abaixo do campo de pesquisa, click em “Create VPC”.
- Vamos criar a topologia por uma opção mais ágil. Em VPC settings, selecione: “VPC and more”.
- Ao concluir a configuração por essa escolha, teremos criado e associado as principais estruturas da topologia, como por exemplo: a Subnet, Route table e Internet gateway.
- Em Auto-generate. Receberá o nome da VPC, insira um de sua escolha, o mesmo refletirá na nomeação das principais estruturas da topologia citado no paragrafo anterior.
- Para o projeto em questão, em Number of Availability Zones (Azs), escolhi: (1).
- Para Number of public subnets. Escolhi: (1).
- Para Number of private subnets. Escolhi: (0).
- Para NAT gateways. Escolhi: (None).
- Para VPC endpoints. Escolhi: (None).
- As demais configurações permaneceram o padrão.
- Finalizando, click em “Create VPC”, em seguida teremos:
  
 ![Captura de Tela (625)](https://github.com/ValmirSGama/Projeto-AWS/assets/111182775/250cffc3-d701-49af-95cc-6149ae29bb99)

#### Segue a configuração da nossa topologia.

 ![Captura de Tela (673)](https://github.com/ValmirSGama/Projeto-AWS/assets/111182775/c72babff-27a4-425c-aec3-680f40542c2f)

- Criar 1 instância EC2 com o sistema operacional Amazon Linux 2 (Família t3.small, 16 GB SSD); 
- Busque por EC2, no campo de pesquisa do console AWS. 
- Na lateral esquerda, click em: “Instances”.
- Na lateral superior direita, click em: “Launch instances”.
- Em name. Nomeie à sua escolha e, insira tags, se necessário.
- Em Quick Start. Foi selecionado o “Amazon Linux”.
- Em Amazon Machine Image (AMI). Foi selecionado o “Amazon Linux 2 AMI (HVM)”.
- Em Instance type. Foi selecionado o “t3.small”.
- Em Key pair. Foi selecionado a chave “.ppk”, criada inicialmente.
- Em Firewall (security groups). Foi escolhido “Select existing security group”.
- Em Common security groups. Foi selecionado o “default” que por padrão, veio com nossa VPC.
- Em Configure storage. Configurado para 16 GB SSD(gp2).
- As demais configurações deixadas por padrão, e então, finalizado em “Launch instance”.
- Abaixo, segue um sumário da nossa instância.

 ![Captura de Tela (674)](https://github.com/ValmirSGama/Projeto-AWS/assets/111182775/fa72c746-8bf3-4aeb-b0cb-9e29863b130a)

### Gerar 1 elastic IP e anexar à instância EC2; 
- Ainda em EC2, na lateral esquerda, Network & Security, escolha: Elastic IPs.
- Na lateral superior direita, click em “Allocate Elastic IP address”.
- Em Network border group. Verifique a região da topologia em questão.
- Insira tags se necessário, e click em “Allocate”.
- Selecione o elastic IP criando e click em Actions, em seguida, selecione “Associate Elastic IP address”.

 ![Captura de Tela (626)](https://github.com/ValmirSGama/Projeto-AWS/assets/111182775/856c30fa-1b99-48be-877a-0494e6708b5c)

- Em Resource type, click em “Inatance”.
- Em Instance, selecione a que criamos.
- Em Private IP address, selecione o que for sugerido ao clicar no campo.
- Em Reassociation, marque “Allow”.
- Por fim, click em “Associate”.
- Ao concluir, asseguramos que o endereço publico da nossa instância permaneça o mesmo.

 ![Captura de Tela (675)](https://github.com/ValmirSGama/Projeto-AWS/assets/111182775/3b8e8557-8a58-48ef-9f6b-c14e02d0cc2c)

- Liberar as portas de comunicação para acesso público: (22/TCP, 111/TCP e UDP, 2049/TCP/UDP, 80/TCP, 443/TCP). 
- Ainda em EC2, na lateral esquerda, Network & Security, click em Security Groups.
- Selecione o grupo da nossa VPC e, em Actions, click em “Edit inbound rules”.
- Segue os protocolos de acesso necessários para este projeto, depois de preenchidos, click em “Save rules”.

 ![Captura de Tela (628)](https://github.com/ValmirSGama/Projeto-AWS/assets/111182775/1304e636-32da-4516-80da-0657bee878c1)

- Vamos cria um 2° Security Group para agir como um firewall.
- Em Security group name. Definna um nome de sua preferência.
- Em Description. Dê uma descrição para o grupo.
- Em VPC. Selecione a VPC que criamos inicialmente.
- Em Inbound rules. Escolha a opção que segue na imagem abaixo e associe este grupo ao grupo da nossa VPC, e o procedimento estará concluído.

 ![Captura de Tela (633)](https://github.com/ValmirSGama/Projeto-AWS/assets/111182775/e7b880bd-e709-4b3f-83ac-bf2daa8d308c)

- Agora criaremos um Elastic File System.
- Busque por EFS, no campo de pesquisa do console AWS. 
- Click em “Create file system”.
- Em Name - optional. Coloque o seu nome.
- Em Virtual Private Cloud (VPC). Selecione a VPC que criamos e click em ”Customize”.

![Captura de Tela (635)](https://github.com/ValmirSGama/Projeto-AWS/assets/111182775/837cecf3-7120-4fba-a798-9fb6f35cc1a9)
  
- Na página seguinte nomeie com seu nome e escolha a opção “One Zone”.
- Em Availability Zone. Cerifique da correspondente à nossa VPC.
- Em Transition into Archive. Escolha a opção “None”, as demais configurações seguem como padrão, click em next.
- Em Virtual Private Cloud (VPC). Escolha a nossa VPC.
- Em Security groups. Desmarque o default e marque o que criamos para agir como um firewall, então click em next em todas as etapas até a opção de “Create”.

![Captura de Tela (642)](https://github.com/ValmirSGama/Projeto-AWS/assets/111182775/447e8b6e-009d-4e46-a211-5b3ff6223229)

- Depois de criado, abra o File system e em seguida click em “Attach”.

![Captura de Tela (643)](https://github.com/ValmirSGama/Projeto-AWS/assets/111182775/f0b31e45-edee-4c8a-be56-b440af40af1e)

- Em Using the NFS client: copie o link e salve num bloco de notas, pois vamos precisar dele para uso posterior.

![Captura de Tela (644)](https://github.com/ValmirSGama/Projeto-AWS/assets/111182775/b87ce41e-232d-476f-b7ad-fcd775d008aa)

- Para verificar se nossa instância EC2 foi configurada corretamente e está acessando a internet, a selecionamos e clicamos em “Connect”.

![Captura de Tela (598)](https://github.com/ValmirSGama/Projeto-AWS/assets/111182775/d41644ec-7acd-4ae0-941e-6d798ca97847)

- Concluído os procedimentos da AWS, vamos precisar baixar e instalar o PuTTY, ele é uma opção para conectar a uma máquina Linux através do sistema operacional Windows.
- Segue o link para o PuTTY: Download PuTTY: latest release (0.80) (greenend.org.uk) .
- Com o PuTTY instalado, vamos fazer as configurações necessárias para acessar a EC2 Linux. 
- Abra o PuTTY e, em Host Name(or IP address), Insira o IPV4 da EC2 Linux.
- Em connection type: selecione SSH.
- Na lateral do menu esquerdo, click em SSH, depois em Auth, e selecione Credentials.
- Em Private-Key file for authentication, click em Browse.
- Você será direcionado a encontrar a chave Key pair que criamos no início, selecione-a para o PuTTY e click em Open.

![Captura de Tela (605)](https://github.com/ValmirSGama/Projeto-AWS/assets/111182775/542eda1c-9418-4371-bd4b-9e699789f641)

- No primeiro acesso ao  PuTTY, aparecerá um painel notificando se você confia no servidor e quer continuar. Click em “Accept”.
- Dendro do  PuTTY, em login as: insira o nome da máquina EC2 Linux, por padrão, é “ec2-user”.
- Agora você está logado.

![Captura de Tela (607)](https://github.com/ValmirSGama/Projeto-AWS/assets/111182775/ee95d3eb-deab-47db-ac6d-474c03fee3cc)

### Requisitos no linux: 
- Configurar o NFS entregue; 
- Para instalar um cliente NFS, vamos executar os seguintes comandos na instância do EC2.
### a. (Opcional) Obtenha atualizações e reinicie com os comandos a seguir. 
      sudo yum -y update  
      sudo reboot  

- Após a reinicialização, reconecte-se à sua instância do EC2.
### b. Instale o cliente NFS com o comando seguir.
      sudo yum -y install nfs-utils
- Agora você monta o sistema de arquivos em sua instância do EC2.
### 1. Crie um diretório ("efs-mount-point") com o comando:
      sudo mkdir /mnt/efs
       
### 2. Monte o sistema de arquivos do Amazon EFS com o comando que salvamos num bloco de notas, segue o exemplo do comando, na parte do “/efs-mount-point”, você colocará o caminho que acabamos de criar para o sistema de arquivos, “/mnt/efs”. 
       sudo mount -t nfs -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport mount-target-DNS:/   ~/efs-mount-point  

![Captura de Tela (623)](https://github.com/ValmirSGama/Projeto-AWS/assets/111182775/cb1ad351-b558-41e0-9bbd-a3034641ad20)


### Confirurando a motagem automática
- vamos realizar uma configuração para que a montagem ocorra automaticamente.
  - Vamos abrir o arquivo para a edição digitando o comando <code>sudo nano /etc/fstab</code>.
  - Dentro do arquivo, acrescente a linha <code>[ID do sismeta de arquivos]:/ [caminho local] nfs4 nfsvers=4.1,rsize=1048576wsize=1048576,hard,timeo=600,retrans=2,noresvport,_netdev 0 0</code>.
  - Substitua o ID do sistema e o caminho local pelas suas credenciais.
  - Usando o comando <code>df -h</code>, poderá verificar se o sistema de arquivos EFS está montado corretamente.
 
### Configurando Apache 
- Instale o Apache com o comando <code>sudo yum install httpd -y</code>.
- Inicie o Apache no sistema com o comando <code>sudo systemctl start httpd</code>.
- Para o Apache iniciar automaticamente, execute o comando <code>sudo systemctl enable httpd</code>.
- Agora verifique se o apache está em execução através do comando <code>sudo systemctl status httpd</code>.

![Captura de Tela (647)](https://github.com/ValmirSGama/Projeto-AWS/assets/111182775/76409ca7-bf8f-45a5-bf8a-b751bc4af56a)

- O Apache vem com uma página inicial padrão, podemos acessá-la através do IP público na barra de endereço de um navegador. É possível editar essa página HTML para exibir o que quisermos. Isso é feito a partir de um arquivo index que pode ser criado dentro do diretório do Apache.
- Para criar/editar esse arquivo, digite o comando <code>sudo nano index.html</code>. O arquivo HTML digitado nesse documento, é o que será mostrado na página acessada pelo IP público. Segui um exemplo de documento HTML.

![Captura de Tela (650)](https://github.com/ValmirSGama/Projeto-AWS/assets/111182775/17c4c607-58b3-4bce-9978-e6eecc17d924)


- Para salvar o documento no editor nano, aperte ctrl+x, depois y e confirme apertando enter.
- Vamos acessar a página e verificar se funcionou, cole o IP público da instância na barra de endereço de um navegador.

![Captura de Tela (649)](https://github.com/ValmirSGama/Projeto-AWS/assets/111182775/d09a99db-876d-40c9-88b5-71858b688780)

### Criar um script validando se o serviço está online ou offline e envie o resultado da validação para o seu diretório no NFS 
- Criaremos um script utilizando um editor de texto, ao final do nome do arquivo, atribuiremos a extensão .sh.
- Para essa atividade, o script deve conter data, hora, nome do serviço, status, mensagem personalizada de ONLINE ou OFFLINE e gerar 2 arquivos de saída: um para o serviço online e outro para o serviço offline.
  - Execute o comando nano <code>service_status.sh</code> para criar e abrir o arquivo do script. Criar o script dentro do diretório EFS. Vamos salvá-lo no caminho /mnt/efs/valmir.
  - Seguir o exemplo do script criado para essa atividade.

![Captura de Tela (652)](https://github.com/ValmirSGama/Projeto-AWS/assets/111182775/ce583e34-6e55-4a61-8cf6-d6ba822f815a)

- No exemplo acima, dentro da estrutura "if/else", indicamos que a condição deve criar no caminho do diretório indicado, e enviar dois arquivos em formato .txt com os resultados da verificação. Sendo um arquivo para o resultado online e outro para o resultado offline.
- Salve o arquivo do script.
- Para tornar o arquivo do script executável digite o comando <code>sudo chmod +x [nome do script]</code>, nesse caso, sudo chmod +x service_status.sh.
- Estando no diretório onde o script foi criado e ativado, execute o comando <code>./service_status.sh</code> para executá-lo. Caso esteja funcionando corretamente e o serviço esteja online, o script vai criar o documento .txt que guarda as informações da validação online.
- Esse documento pode ser lido com o comando cat + nome do documento: <code>cat httpd-online.txt</code>. Verificaque o funcionamento do script na imagem abaixo.

 ![Captura de Tela (669)](https://github.com/ValmirSGama/Projeto-AWS/assets/111182775/6144d736-0bf7-461b-b104-5d20f498215c)


- O documento informa a data e a hora em que a verificação foi feita, assim como o nome do serviço verificado e uma mensagem indicando que o mesmo está online.

  ###  Prepar a execução automatizada do script a cada 5 minutos

- Para o agendamento da execução do script vamos utilizar o comando crontab.
  - Digite o comando <code>EDITOR=nano crontab -e</code>, para que o nano abra o arquivo crontab.
Dentro do arquivo digite a linha <code>*/5 * * * * /[caminho de onde está o script/nome do script]</code>. Em nosso caso, ficou dessa forma: <code>*/5 * * * * /mnt/efs/valmir/service_status.sh</code>
Salve o arquivo e feche o editor.
Para verificar se a automatização está funcionando, é preciso abrir os arquivos .txt que foram programados para serem criados e guardar as informações da verificação do serviço online e offline. Como a automatização faz com que a verificação programada pelo script ocorra a cada 5 minutos, dê algum tempo para que o arquivo .txt seja atualizado algumas vezes.
  - Abaixo temos a demonstração do arquivo httpd-online.txt exibindo as informações da validação online.

![Captura de Tela (663)](https://github.com/ValmirSGama/Projeto-AWS/assets/111182775/5eaad49d-1249-4956-ade8-79c969f2d5da)

- Para fazermos a confirmação de que o script realiza a verificação do serviço offline, é preciso interromper o Apache com o comando <code>sudo systemctl stop httpd</code>. Dessa forma, basta aguardar alguns minutos para que o crontap continue executando o script a cada 5 minutos, e poderemos ver a criação do arquivo httpd-offline.txt, que exibe os momentos em que o status do serviço estava offline, segue exemplo.

![Captura de Tela (664)](https://github.com/ValmirSGama/Projeto-AWS/assets/111182775/3e115d20-a34a-4dd4-bc44-130caf378483)

- Podemos verificar que os arquivos .txt foram criados dentro do diretório indicado no script.

![Captura de Tela (668)](https://github.com/ValmirSGama/Projeto-AWS/assets/111182775/863e6e6a-771b-4725-9a52-a13ffebd32ee)

- Projeto criando durante o programa de bolsas da Compass.uol com pareceria com a Unicesumar no mês: 04/2024
- Os endereços IP aqui expostos, foram utilizados apenas para o laboratório desta atividade. Por segurança, ao termino da mesma, essa tópologia foi excluída.
  
### Referencia para a criação do projeto
- https://docs.aws.amazon.com/efs/latest/ug/wt1-test.html#wt1-connect-test-gather-info
