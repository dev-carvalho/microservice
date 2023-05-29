Para toda decisão arquitetônica, há um trade-off a ser considerado.

- Consistencia de Dados
- Comunicação entre serviços

## Como é uma arquitetura típica de microsserviços? 👇

O diagrama abaixo mostra uma arquitetura típica de microsserviços.



- Load Balancer: distribui o tráfego de entrada entre vários serviços de back-end.

- CDN (Content Delivery Network): CDN é um grupo de servidores distribuídos geograficamente que armazenam conteúdo estático para uma entrega mais rápida. Os clientes procuram conteúdo na CDN primeiro e, em seguida, progridem para os serviços de back-end.

- API Gateway: lida com solicitações de entrada e as roteia para os serviços relevantes. Ele conversa com o provedor de identidade e a descoberta de serviço.

- Provedor de identidade: lida com autenticação e autorização para usuários.

- Registro de Serviço & Descoberta: o registro e a descoberta de microsserviços acontecem neste componente, e o gateway de API procura serviços relevantes nesse componente para conversar.

- Gestão: Este componente é responsável pelo monitoramento dos serviços.

- Microsserviços: os microsserviços são projetados e implantados em diferentes domínios. Cada domínio tem seu próprio banco de dados. O gateway de API conversa com os microsserviços por meio da API REST ou outros protocolos, e os microsserviços dentro do mesmo domínio conversam entre si usando RPC (Remote Procedure Call).

- Benefícios dos microsserviços:
1. Eles podem ser rapidamente projetados, implantados e dimensionados horizontalmente.
2. Cada domínio pode ser mantido de forma independente por uma equipe dedicada.
3. Os requisitos de negócios podem ser personalizados em cada domínio e melhor suportados, como resultado.

#### Para você: 
1). Quais são as desvantagens da arquitetura de microsserviços?
2). Você já viu um sistema monolítico ser transformado em arquitetura de microsserviços? Quanto tempo demora?


