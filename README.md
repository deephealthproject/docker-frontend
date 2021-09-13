![GitHub release (latest by date)](https://img.shields.io/github/v/release/deephealthproject/docker-frontend) ![GitHub](https://img.shields.io/github/license/deephealthproject/docker-frontend)


# docker-frontend

Containerization of the DeepHealth front-end (see [https://github.com/deephealthproject/front-end](https://github.com/deephealthproject/front-end)).

Keep on reading to see how to [deploy on Kubernetes](#deploy-on-kubernetes) (see [here](https://github.com/deephealthproject/front-end) to run it and develop on [docker-compose](#develop-with-dockerCompose)).




## Deploy on Kubernetes

### Installation

1. Add the `helm-charts` repository:

```bash
helm repo add dhealth https://deephealthproject.github.io/helm-charts/
helm repo update
```

2. Download the `values.yaml` template:

```bash
curl https://raw.githubusercontent.com/deephealthproject/docker-frontend/master/k8s/deephealth-frontend/values.yaml -o values.yaml
```

3. Edit the `values.yaml` to configure your deployment ([here](#helm-chart-parameters) the available parameters)
4. To install the chart with the release name `deephealth-frontend` :

```bash
helm install --name deephealth-frontend dhealth/deephealth-frontend -f values.yaml
```

Take a look at the deployment notes to know how to access services  (`helm status deephealth-frontend`).



#### Installation from sources

1. Clone the [`docker-frontend`](https://github.com/deephealthproject/docker-frontend) repository:

```
git clone git@github.com:deephealthproject/docker-frontend.git
```

2. Edit the ´k8s/values.yaml´ template to configure your deployment ([here](#helm-chart-parameters) the available parameters)

4. Deploy on Kubernetes through `helm`:

```
helm install --name deephealth-frontend k8s/deephealth-frontend -f k8s/values.yaml
```

Take a look at the deployment notes to know how to access services  (`helm status deephealth-frontend`).



### Access via Ingress

If an Ingress Controller is available on your Kubernetes cluster, you can access the front-end endpoint by setting the upper level `ingress` property on the `values.yaml` file.  Here is an example:

```
ingress:
  enabled: true
  annotations:
    kubernetes.io/ingress.class: nginx
    # kubernetes.io/tls-acme: "true"
  hosts:
    - host: frontend.172.30.10.101.nip.io
      paths:
        - "/"
```



### Parameters

The following tables lists the main configurable parameters of the `deephealth-frontend` chart and their default values.

| Parameter           | Description                                                                                              | Default            |
| ------------------- | -------------------------------------------------------------------------------------------------------- | ------------------ |
| `backend.apiUrl`    | URL of the DeepHealth Back-end API                                                                       | `nil`              |
| `backend.clientId`  | OAuth Client ID that you can get registering the front-end at <backend-host>/backend/auth/applications/  | `nil`              |
| `service.type`      | Kubernetes service type of the front-end                                                                 | `NodePort`         |
| `ingress.enabled`   | Enable the ingress for the front-end service                                                             | `false`            |
| `ingress.annations` | Annotations for the ingress related with the front-end service                                           | `{}`               |
| `ingress.hosts`     | Hosts paths for the ingress related with the front-end service (see example on `values.yaml`)            | `nil`              |
| `image.repository`  | Front-end App Docker Image                                                                               | `dhealth/frontend` |
| `image.tag`         | Front-end App Docker Image Tag                                                                           | `latest`           |
| `image.pullPolicy`  | Pull policy for the front-end App Docker Image                                                           | `IfNotPresent`     |
| `image.pullSecrets` | Specify docker-registry secret names as an array                                                         | `[]`               |
| `replicaCount`      | Number of replicas of the the front-end server                                                           | `1`                |
| `resources`         | CPU/Memory resource requests/limits of the front-end server replica                                      | `nil`              |
| `nodeSelector`      | Node labels for pod assignment of the front-end server replicas                                          | `nil`              |
| `tolerations`       | Tolerations labels for pod assignment of the front-end server repliacas                                  | `nil`              |
| `affinity`          | Affinity labels for pod assignment of the front-end server replicas                                      | `nil`              |



## License

This software is distributed under the [MIT License](https://opensource.org/licenses/MIT), see [LICENSE](./LICENSE) for more information.
