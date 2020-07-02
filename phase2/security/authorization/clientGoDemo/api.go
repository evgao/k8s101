package main

import (
    "context"
    "fmt"
    "time"
    "bytes"
    "net/http"
    "strconv"
    "encoding/json"


    "k8s.io/apimachinery/pkg/api/errors"
    metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
    "k8s.io/client-go/kubernetes"
    "k8s.io/client-go/rest"
    //"k8s.io/client-go/tools/clientcmd"
)



func main() {
    // creates the in-cluster config
    config, err := rest.InClusterConfig()
    //config, err := clientcmd.BuildConfigFromFlags("", "/root/.kube/config")
    if err != nil {
        panic(err.Error())
    }
    // creates the clientset
    clientset, err := kubernetes.NewForConfig(config)
    if err != nil {
        panic(err.Error())
    }

    type Payload struct  {
        Username string `json:"username"`
        Message string `json:"message"`
    }


    //
    for {
        // get pods in all the namespaces by omitting namespace
        // Or specify namespace to get pods in particular namespace
        pods, err := clientset.CoreV1().Pods("").List(context.TODO(), metav1.ListOptions{})
        if err != nil {
            panic(err.Error())
        }
        fmt.Printf("There are %d pods in the cluster, recording in api server.\n", len(pods.Items))

        data := Payload {
            Username: "PodSum - " +  time.Now().Format("2006-01-02 15:04"),
            Message: strconv.Itoa(len(pods.Items)),
        }

        payloadBytes, err := json.Marshal(data)
        if err != nil {
            panic(err)
        }
        body := bytes.NewReader(payloadBytes)
        req, err := http.NewRequest("POST", "http://frontend-svc:3000/api", body)
        if err != nil {
            panic(err)
        }
        req.Header.Set("Content-Type", "application/json")
        resp, err := http.DefaultClient.Do(req)
        if err != nil {
            panic(err)
        }
        defer resp.Body.Close()



        // Examples for error handling:
        // - Use helper functions e.g. errors.IsNotFound()
        // - And/or cast to StatusError and use its properties like e.g. ErrStatus.Message
        _, err = clientset.CoreV1().Pods("default").Get(context.TODO(), "example-pod", metav1.GetOptions{})
        if errors.IsNotFound(err) {
            fmt.Printf("Pod example-pod not found in default namespace\n")
        } else if statusError, isStatus := err.(*errors.StatusError); isStatus {
            fmt.Printf("Error getting pod %v\n", statusError.ErrStatus.Message)
        } else if err != nil {
            panic(err.Error())
        } else {
            fmt.Printf("Found example-pod pod in default namespace\n")
        }

        fmt.Println()
        time.Sleep(60 * time.Second)
    }
}
