"use strict";

exports.headers = function (resp) {
  return resp.headers;
};

exports.ok = function (resp) {
  return resp.ok;
};

exports.redirected = function (resp) {
  return resp.redirected;
};

exports.status = function (resp) {
  return resp.status;
};

exports.statusText = function (resp) {
  return resp.statusText;
};

exports.url = function (resp) {
  return resp.url;
};

exports.body = function (resp) {
  return function() {
    return resp.body;
  };
};

exports.arrayBuffer = function (resp) {
  return function() {
    return resp.arrayBuffer();
  };
};

exports.blob = function (resp) {
  return function() {
    return resp.blob();
  };
};

exports.text = function (resp) {
  return function() {
    return resp.text();
  };
};
